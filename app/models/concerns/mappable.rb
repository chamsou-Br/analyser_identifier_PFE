# frozen_string_literal: true

module Mappable
  extend ActiveSupport::Concern

  REQUIRED_ATTRS = %w[email firstname lastname].freeze
  ADDITIONAL_ATTRS = %w[phone mobile_phone function service groups roles].freeze

  module ClassMethods
    def required_attributes
      Mappable::REQUIRED_ATTRS.map { |sub_attr| "#{sub_attr}_key".to_sym }
    end

    def additional_attributes
      Mappable::ADDITIONAL_ATTRS.map { |sub_attr| "#{sub_attr}_key".to_sym }
    end
  end
end
