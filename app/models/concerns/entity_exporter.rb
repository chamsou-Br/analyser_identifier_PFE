# frozen_string_literal: true

#
# This module provides the method `csv_export` (and more to come) to any
# entity which includes the module with:
#   `include EntityExporter`.
# The method can be called with (more information above the method):
#   `ModelName.export_csv(params)`.
#
module EntityExporter
  extend ActiveSupport::Concern

  # Returns a value as a string given an attribute name
  #
  # @param element [Record] ActiveRecord Element from which
  #   we get the value
  # @param key [String] String key for model attribute
  # @raise [RuntimeError] Incorrect attribute if element doesn't have 'key'
  #   attribute
  # @raise [NoMethodError] if column_hash doesn't exist with in the element
  #   class
  # @raise [AttributeError] if type doesn't exist for column_hash[key]
  # @return [String] Return a value parsed if needed
  #
  # rubocop:disable Metrics/CyclomaticComplexity
  def self.get_value(element, key)
    if element.has_attribute?(key)
      value_type = element.class.columns_hash[key].type
      value = element[key]
    elsif element.class.method_defined? key.to_sym
      value = element.send(key)
      value_type = value.class.name.downcase.to_sym
    else
      raise "Incorrect attribute #{key} asked, might need special parsing"
    end
    return "" if value.nil?

    # Probably more default treatments to come
    # Switch between different attributes types from the type of the attribute

    case value_type
    when :string
      # TODO: Add a dynamic translation in case attribute can be translated
      # Need a rework of the yml translation file structure to be consistent
      value.strip
    when :integer, :boolean
      value
    when :datetime, :date
      value.strftime("%Y-%m-%d")
    when :array
      value.join(",")
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  # Method that generate the CSV object
  #
  # @param table_name [String] the table name (got from element class and
  #   use for translation)
  # @param keys [Array] Array of string, each string being an attribute
  #   of the related model
  # @param all_values [Array] Array of all values built in export_csv
  # @param csv [Csv] Csv object from CSV.generate
  # @param head_translation [String] String with a different path for header
  #   translation if needed
  # @return [Array<Array<String>>] Return an Array of array in csv format
  #
  def self.create_csv(table_name, keys, all_values, csv, head_translation = "")
    translated_headers = keys.reduce([]) do |memo, key|
      translation_path = if head_translation.empty?
                           "#{table_name}.csv.columns"
                         else
                           head_translation
                         end
      memo << I18n.t("#{translation_path}.#{key}", default: key.to_s)
    end
    csv << translated_headers
    all_values.each { |value| csv << value }
  end

  # Return the value choosing between default parsing or by calling
  # a proc from the hash special_keys
  #
  # @param special_keys [Array] Hash with model attributes as keys linked to
  #   an anonymous method doing a special parsing for this attribute with
  #   element in parameter
  # @param key [String] String key for model attribute
  # @param element [ActiveRecord object] ActiveRecord Element from which
  #   we get the value
  # @raise RuntimeError if the passed argument isn't a proc for special parsing
  # @return [any] a value from proc call or from get_value method
  #
  def self.default_or_special_parsing(special_keys, key, element)
    if special_keys.key?(key.to_sym)
      # rubocop:disable Style/IfUnlessModifier
      if special_keys[key.to_sym].class != Proc
        raise "Passed argument for export isn't a proc"
      end
      # rubocop:enable Style/IfUnlessModifier

      special_keys[key.to_sym].call(element)
    else
      EntityExporter.get_value(element, key)
    end
  end

  class_methods do
    # This method interates through the data and generates an array of arrays
    # with the headers and the value asked for in the arguments.
    #
    # @param elements [Array<Record>] Array to be exported.
    # @param keys [Array<String>] Each string in the array is an attribute
    #   of the related model.
    # @param special_keys [Hash] Hash with model attributes as keys which
    #   values are anonymous methods doing a special parsing for the attribute
    #   using `element` in `parameter`
    # @param head_translation [String] String with a different path for header
    #   translation if needed
    # @return [Array] Return an Array of arrays in csv format with all
    #   the values/columns you asked for
    #
    def export_csv(elements, keys, special_keys = {}, head_translation = "")
      CSV.generate({}) do |csv|
        all_values = elements.inject([]) do |outer_result, element|
          element_array = keys.inject([]) do |inner_result, key|
            inner_result << EntityExporter.default_or_special_parsing(
              special_keys, key, element
            )
          end
          outer_result << element_array
        end
        EntityExporter.create_csv(
          elements.first.class.table_name,
          keys,
          all_values,
          csv,
          head_translation
        )
      end
    end
  end
end
