# frozen_string_literal: true

module Trackable
  extend ActiveSupport::Concern

  attr_accessor :_dirty_attributes

  #
  # Manually marks the attribute having `name` as dirty since this model was last
  # saved. Can be used inside a proc or method in an ActiveRecord association
  # callback to track association changes (there's no way to get the association
  # name dynamically in such callbacks, otherwise this could have been written
  # to work as a callback directly).
  #
  # @example Tracking association changes
  #   has_many: things,
  #             after_add: proc { |entity| entity.mark_dirty_attribute :thing_ids }
  #             after_add: proc { |entity| entity.mark_dirty_attribute :thing_ids }
  #
  # @note Extending this to track values in `ActiveModel::Dirty`'s
  #   `@previously_changed` and `@changed_attributes` would be fragile. It
  #   would break if used in `after_*` callbacks as the previous value would be
  #   lost, and use in `before_*` callbacks would not guarantee the operation
  #   would be successful.
  #
  # @param [Symbol] name Name of the attribute.
  #
  # rubocop: disable Style/IfUnlessModifier (for 80 char limit)
  def mark_dirty_attribute(name)
    unless respond_to?(name)
      raise ArgumentError, "#{name} is not an attribute of #{self}"
    end

    self._dirty_attributes ||= Set[]
    self._dirty_attributes.add(name)
  end
  # rubocop: enable Style/IfUnlessModifier

  # Same as `mark_dirty_attribute` but for actors. Actors handling needs to be
  # special as we are moving from and attribute like `event.owner_id` to the
  # association actor for each of the responsibilities.
  # Given that today `2022-11-24` the move to actor is being implemented only
  # for events, a guard will be introduced.
  # (for 80 char limit)
  def mark_dirty_actor(actor)
    return unless instance_of? Event

    unless respond_to?(actor.responsibility) || respond_to?("#{actor.responsibility}s")
      raise ArgumentError,
            "#{actor.responsibility} is not a responsibility of #{self}"
    end

    self._dirty_attributes ||= Set[]
    self._dirty_attributes.add(actor.responsibility)
  end

  #
  # Returns an array of all dirty attribute names for this model since it was
  # last saved.
  #
  # @return [Array<Symbol>]
  #
  def dirty_attributes
    # Compact to avoid `[nil]` for empty sets.
    self._dirty_attributes.to_a.compact
  end

  #
  # Hooks the `ActiveRecord::Base#reload` to clear the set of dirty
  # associations.
  #
  def reload(*)
    super.tap do
      self._dirty_attributes = Set[]
    end
  end

  def object_has_changed?(action, current_hash)
    action == "create" || attributes_tracked_changed? || many_associations_tracked_changed?(current_hash)
  end

  def attributes_tracked_changed?
    attributes_to_track.any? do |attribute|
      saved_changes.key? attribute
    end
  end

  def many_associations_tracked_changed?(current_hash)
    return if timeline_items.last.nil?

    previous_hash = timeline_items.last.parsed_object
    many_associations_to_track.any? do |association|
      !current_hash[association.to_s].nil? && previous_hash[association.to_s] != current_hash[association.to_s]
    end
  end

  def association_tracked?(association)
    many_associations_to_track.include? association
  end
end
