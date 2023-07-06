# frozen_string_literal: true

module Workflow
  extend ActiveSupport::Concern

  # TODO: Should be part of the logic of the transition in the state machine
  #
  # This seems very state-machine-like and could probably be refactored into
  # smaller, state-change-related notifiers
  # TODO: Refactor `notify_state_change` into state-machine
  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def notify_state_change(from_user, old_state, new_state)
    pilot = respond_to?(:pilot) ? self.pilot : nil
    author_category = nil
    pilot_category = nil
    to_category = nil
    extra_message = nil
    to_other_users = []
    params = { customer: customer, entity: self }

    # The entity has been sent to verification
    if new_state == "verificationInProgress"
      extra_message = news if is_new_version?
      unless author == from_user
        author_category = verifiers.include?(author) ? :verification_request_author : :sent_verification_author
      end
      unless pilot.nil? || pilot == from_user
        pilot_category = verifiers.include?(pilot) ? :verification_request_pilot : :sent_verification_pilot
      end
      to_category = :verification_request_other
      to_other_users = verifiers
    end

    # The entity has been sent to approval
    if new_state == "approvalInProgress"
      extra_message = news if is_new_version?
      unless author == from_user
        author_category = approvers.include?(author) ? :approval_request_author : :sent_approval_author
      end
      unless pilot.nil? || pilot == from_user
        pilot_category = approvers.include?(pilot) ? :approval_request_pilot : :sent_approval_pilot
      end
      to_category = :approval_request_other
      to_other_users = approvers
    end

    # The entity has been sent to publication
    if new_state == "approved"
      extra_message = news if is_new_version?
      unless author == from_user
        author_category = author == publisher ? :publication_request_author : :sent_publication_author
      end
      unless pilot.nil? || pilot == from_user
        pilot_category = pilot == publisher ? :publication_request_pilot : :sent_publication_pilot
      end
      to_category = :publication_request_other
      to_other_users = [publisher]
    end

    # The entity is applicable
    if new_state == "applicable"
      extra_message = news if is_new_version?
      author_category = :applicable_author unless author == from_user
      pilot_category = :applicable_pilot unless pilot.nil? || pilot == from_user
      to_category = :applicable_other
      to_other_users = viewers
      viewergroups.each { |group| to_other_users += group.users }
      viewerroles.each { |role| to_other_users += role.users }
    end

    # The entity is deactivated
    if new_state == "deactivated"
      author_category = :deactivated_author unless author == from_user
      pilot_category = :deactivated_pilot unless pilot.nil? || pilot == from_user
      to_category = :deactivated_other
      to_other_users = viewers
      viewergroups.each { |group| to_other_users += group.users }
    end

    # The entity has been reactivated
    if (new_state == "applicable") && (old_state == "deactivated")
      author_category = :reactivated_author unless author == from_user
      pilot_category = :reactivated_pilot unless pilot.nil? || pilot == from_user
      to_category = :reactivated_other
      to_other_users = viewers
      viewergroups.each { |group| to_other_users += group.users }
    end

    # The entity has been refused during verification or approval
    if (new_state == "new") && old_state =~ /^(verification|approval)InProgress$/
      author_category = :refusal_author unless author == from_user
      pilot_category = :refusal_pilot unless pilot.nil? || pilot == from_user
      to_category = :refusal_other
      to_other_users = old_state.start_with?("verification") ? verifiers : approvers
    end

    if author_category
      NewNotification.create_and_deliver(params.merge(
                                           category: author_category,
                                           from: /request/.match?(author_category) ? nil : from_user,
                                           to: author
                                         ), extra_message)
    end

    if pilot_category
      NewNotification.create_and_deliver(params.merge(
                                           category: pilot_category,
                                           from: /request/.match?(pilot_category) ? nil : from_user,
                                           to: pilot
                                         ), extra_message)
    end

    return unless to_category

    (to_other_users - [from_user, author, pilot]).compact.uniq.each do |user|
      NewNotification.create_and_deliver(
        params.merge(category: to_category,
                     from: /request/.match?(to_category) ? nil : from_user,
                     to: user),
        extra_message
      )
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  # Returns `true` if the entity is a new version which became applicable
  # TODO: Rename `is_new_version?` to `new_version?`
  # rubocop:disable Naming/PredicateName
  def is_new_version?
    !parent.nil?
  end
  # rubocop:enable Naming/PredicateName

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def next_state(sender, deactivation = false)
    new_state = case state
                when "new"
                  if verifiers.count.positive?
                    "verificationInProgress"
                  elsif approvers.count.positive?
                    "approvalInProgress"
                  else
                    "approved"
                  end
                when "verificationInProgress"
                  if is_verified?
                    if approvers.count.positive?
                      "approvalInProgress"
                    else
                      "approved"
                    end
                  else
                    state
                  end
                when "approvalInProgress"
                  if is_approved?
                    "approved"
                  else
                    state
                  end
                when "approved"
                  if is_published?
                    "applicable"
                  else
                    state
                  end
                when "applicable"
                  if deactivation
                    "deactivated"
                  elsif in_application?
                    "archived"
                  else
                    # FIXME: This branch is not possible because
                    # `in_application?`` checks `state == "applicable"` which
                    # is already the case from the `when` clause.
                    state
                  end
                when "deactivated"
                  "applicable"
                else
                  state
                end

    if new_state == state
      false
    else
      unless new_state == "verificationInProgress"
        entity_log_klass.create(
          entity_id => id,
          user_id: sender.id,
          action: translate_state(new_state, state), comment: nil
        )
      end
      old_state = state
      self.state = new_state
      if save
        notify_state_change(sender, old_state, new_state)
        if in_application? && !parent.nil?
          # Passage de tous les autres applicable et deactivated à archived
          # TODO: generalize
          all_versions.where.not(id: id, state: "archived")
                      .where(state: %w[applicable deactivated])
                      .each do |entity_to_archive|
            entity_to_archive.archive
            entity_log_klass.create(entity_id => entity_to_archive.id,
                                    user_id: sender.id,
                                    action: "archived",
                                    comment: nil)
          end
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  def translate_state(actual_state, old_state)
    case actual_state
    when "verificationInProgress"
      "wf_started"
    when "approvalInProgress"
      "verified"
    when "applicable"
      if old_state == "deactivated"
        "activated"
      else
        "published"
      end
    else
      actual_state
    end
  end

  private

  def entity_log_klass
    "#{model_name.to_s.pluralize}Log".constantize
  end

  def entity_id
    "#{model_name.to_s.downcase}_id".to_sym
  end
end
