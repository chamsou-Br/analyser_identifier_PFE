# frozen_string_literal: true

# This module is responsible for listing and sanitizing fields
# for a model in which it is included
module Sanitizable
  extend ActiveSupport::Concern

  included do
    before_validation :scrub_unsafe_html

    class_attribute :sanitizable_fields
  end

  module ClassMethods
    # Allows to list fields to sanitize for a given model
    #
    # @param [Array<Symbol>] *fields
    def sanitize_fields(*fields)
      self.sanitizable_fields = fields
    end
  end

  private

  # Leverages the Loofah scrubber to sanitize fields marked for processing
  #
  # @private
  def scrub_unsafe_html
    sanitizable_fields.each do |field_to_process|
      unsafe_html = send(field_to_process)
      next if unsafe_html.nil?

      sanitized = if Loofah.fragment(unsafe_html).is_a?(Nokogiri::HTML::DocumentFragment)
                    Loofah.fragment(unsafe_html).scrub!(:prune)
                  elsif Loofah.document(unsafe_html).is_a?(Nokogiri::HTML::Document)
                    Loofah.document(unsafe_html).scrub!(:prune)
                  end.to_s.gsub(/&amp;/, "&")
      send("#{field_to_process}=", sanitized)
    end
  end
end
