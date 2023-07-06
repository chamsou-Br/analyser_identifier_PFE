# frozen_string_literal: true

#
# This module/concern generates the internal reference of an entity, only if
# such reference does not already exist.
# The method is meant to be used inside a transaction when creating an entity
# to allow rollback of database writes (increment of counters).
#
# The method is taken almost verbatim from the improver implementation at
# `app/controllers/concerns/improver_two_helpers.rb`
#
module InternalReference
  extend ActiveSupport::Concern

  included do
    def generate_internal_ref
      return if internal_reference

      reference_counter = customer.reference_counter
      entity_sym = self.class.to_s.downcase.to_sym
      # The exclamation mark (!) saves to the database
      reference_counter.increment!(entity_sym)
      self.internal_reference = reference_counter.send("formated_#{entity_sym}_counter")
    end
  end
end
