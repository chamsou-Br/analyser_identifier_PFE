# frozen_string_literal: true

#
# Adds `print_footer` validation and `custom_print_footer` providing fallbacks
# when printing an entity footer
#
# @note Expects the including model to define a `print_footer` string writable
#   attribute and a `customer` Customer attribute
#
module PrintableFooter
  extend ActiveSupport::Concern

  included do
    validates :print_footer, length: { maximum: 100 }
  end

  # @!attribute [rw] print_footer
  #   @return [String, nil] print footer for the entity

  # @!attribute [rw] customer
  #   @return [Customer] customer to whom the entity belongs

  #
  # Custom footer when printing this entity, falling back to any
  # customer-specific footer is none exists for said entity
  #
  # @return [String]
  #
  def custom_print_footer
    print_footer.presence ||
      customer.settings.print_footer.presence ||
      ""
  end

  def custom_print_footer=(value)
    self.print_footer = value
  end
end
