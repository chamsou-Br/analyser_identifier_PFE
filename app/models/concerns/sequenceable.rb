# frozen_string_literal: true

module Sequenceable
  extend ActiveSupport::Concern

  included do
    before_create :set_sequence
  end

  def set_sequence
    last_record = self.class
                      .where(customer_setting: customer_setting)
                      .where.not(sequence: nil)
                      .last
    self.sequence = if last_record.blank?
                      1
                    else
                      last_record.sequence + 1
                    end
  end
end
