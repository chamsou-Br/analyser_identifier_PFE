# frozen_string_literal: true

module SequenceableByCustomer
  extend ActiveSupport::Concern

  included do
    before_create :set_sequence
  end

  def set_sequence
    # Get the greatest used `sequence` from any record of this type under this `customer`
    last_sequence = self.class
                        .where(customer: customer)
                        .where.not(sequence: nil)
                        .order(sequence: :desc)
                        .limit(1)
                        .pluck(:sequence)
                        .first
    self.sequence = last_sequence.blank? ? 1 : last_sequence + 1
  end
end
