# frozen_string_literal: true

# This module exist solely for the purpose of the transfer from the original
# way of storing responsibilties to the actorr in the IAM service.
#
module EventContributable
  extend ActiveSupport::Concern
  include Trackable

  included do
    has_many :contributables_contributors, as: :contributable,
                                           dependent: :destroy
    has_many :orig_contributors, through: :contributables_contributors,
                                 after_add: :mark_dirty_contributor_ids,
                                 after_remove: :mark_dirty_contributor_ids

    has_many :contributions, as: :contributable, dependent: :destroy
    accepts_nested_attributes_for :contributions, allow_destroy: true
  end

  #
  # Marks the `contributor_ids` for the including model as dirty, for use as an
  # association callback.
  #
  def mark_dirty_contributor_ids(_record)
    mark_dirty_attribute :orig_contributor_ids
  end

  def active_contributions
    contributions
  end

  def contributors_and_default_contributors
    return [] if new_record?

    User.where(
      "id in (?) or id in (?)",
      contributors.select(:id),
      default_contributors.select(:id)
    )
  end

  # Override this as needed in target active record
  def default_contributors
    # TODO: `author` should be injected as an argument as this concern has no
    # knowledge of the classes that include it while currently requiring them
    # to implement `author`.
    User.where(id: author)
  end

  # Override this as needed in target active record
  def contribution_editable?
    true
  end

  #
  # Is the provided user a contributor to this event?
  #
  # @note This method relies on the `contributors` relation which may incur
  #   additional queries if said relation is not preloaded.
  #
  # @param [User] User whose role as a contributor we wish to confirm
  #
  # @return [Boolean]
  #
  def involves_contributor?(user)
    contributors.include?(user)
  end

  module ClassMethods
  end
end
