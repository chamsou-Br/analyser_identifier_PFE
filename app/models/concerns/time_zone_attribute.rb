# frozen_string_literal: true

#
# Adds `time_zone` attribute-related logic and validation
#
# @note This module expects the including class/module to have a `time_zone`
#   method.
#
module TimeZoneAttribute
  extend ActiveSupport::Concern

  # @!attribute time_zone
  #   @return [String]

  included do
    validates :time_zone, length: { maximum: 255 }
    validate :check_time_zone
  end

  #
  # Validates the `time_zone` attribute, adding an ActiveRecord error if invalid
  #
  # @return [void]
  #
  def check_time_zone
    errors.add :time_zone, :invalid unless valid_time_zone?
  end

  #
  # Returns a unique list of time zones present in the including class.
  #
  # @return [Array<String>] String represents the time zone
  #
  module ClassMethods
    def time_zones
      distinct.where.not(time_zone: nil).pluck(:time_zone)
    end
  end

  private

  #
  # Is the `time_zone` valid?
  #
  # Valid `time_zone` values are either `nil` or time zone strings supported by
  # `ActiveSupport::TimeZone`.
  #
  # @see https://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html
  #
  # @return [Boolean]
  #
  def valid_time_zone?
    time_zone.nil? || ActiveSupport::TimeZone[time_zone].present?
  end
end
