# frozen_string_literal: true

#
# This module/concern encapsulates relations and behavior common to all entities
# that use form fields, field items and field values to store information.
#
module FieldableEntity
  extend ActiveSupport::Concern

  attr_accessor :_dirty_fields

  included do
    # @return [Array<FieldValue>]
    has_many :fieldable_values, as: :fieldable,
                                class_name: "FieldValue",
                                dependent: :destroy,
                                after_add: :mark_dirty_field,
                                after_remove: :mark_dirty_field

    # @return [Array<FieldValue>]
    has_many :linkable_values, as: :entity,
                               class_name: "FieldValue",
                               dependent: :destroy

    accepts_nested_attributes_for :fieldable_values, allow_destroy: true

    # This scope preloads field items and form fields associated with field
    # values
    scope :with_preloaded_fields, lambda {
      preload(fieldable_values: %i[form_field entity])
    }
  end

  #
  # Marks the `FormField` the given `field_value` belongs to as dirty for this
  # model since the model was last saved. Intended for use as an ActiveRecord
  # association callback.
  #
  # param [FieldValue] field_value
  #
  def mark_dirty_field(field_value)
    self._dirty_fields ||= Set[]
    self._dirty_fields.add(field_value.form_field)
  end

  #
  # Returns an array of all dirty form fields for this model since it was last
  # saved.
  #
  # @return [Array<FormField>]
  #
  def dirty_fields
    self._dirty_fields.to_a.compact
  end

  #
  # Hooks the `ActiveRecord::Base#reload` to clear the set of dirty fields.
  #
  def reload(*)
    super.tap do
      self._dirty_fields = Set[]
    end
  end

  # Return form fields for the given entity type under the entity's customer
  #
  # @return [Array<FormField>]
  def form_fields
    return [] unless customer

    customer.form_fields.select do |field|
      field.app_model == self.class.to_s.downcase
    end
  end

  # Assemble the fieldables of the event, grouped by section name, In each
  # section, have only one element per field_name, where 'value' is an array
  # of the relevant values in found in the fieldable.
  #
  # @return [Hash]
  #
  # @note This method relies on the `field_item` as entity and `form_field`
  #   relations of `FieldValue` which may incur additional queries if said
  #   relations are not preloaded.
  #
  # @note this method is somewhat temporary; it will be replace when graphql
  # can resolve the event list page.
  def field_value_hash
    hash = {}
    assemble_fieldables(hash)
    hash.each_key { |section| hash[section] = flatten_spec(hash, section) }
    hash
  end

  # This method takes a hash in the form:
  # {:spec=>{:field_name=>"graphs_impacts"}, :value=>{:value=>nil, :entity_id=>1000}},
  # {:spec=>{:field_name=>"graphs_impacts"}, :value=>{:value=>nil, :entity_id=>1001}},
  # {:spec=>{:field_name=>"graphs_impacts"}, :value=>{:value=>nil, :entity_id=>1002}},
  #
  # and returns
  # {:spec=>{:field_name=>"graphs_impacts"},
  #  :value=>[{:value=>nil, :entity_id=>1000}},
  #           {:value=>nil, :entity_id=>1001}},
  #           {:value=>nil, :entity_id=>1002}}]
  #
  # group_by: returns a hash, which keys are evaluated from the block, here
  #   {:field_name=>"graphs_impacts"}, and the values, arrays of full element
  #   corresponding to the key in the field values.
  # transform_values: returns a new hash with the result of running the block
  #   for each value and the keys are unchanged. So here for each key
  #   {:field_name=>"graphs_impacts"}, the result is an array of values.
  # reduce will create a new array of hashes, where each hash has the first
  #   element has as key :spec and value is passed the same.
  #
  # The arguments are the bloated hash and the section_name
  #
  # @note this method is somewhat temporary; it will be replace when graphql
  # can resolve the event list page.
  def flatten_spec(hash, section_name)
    return unless hash[section_name]

    hash[section_name]
      .group_by { |form_field| form_field[:spec] }
      .transform_values { |vals| vals.map { |val| val[:value] } }
      .reduce([]) do |memo, (key, vals)|
        memo << { spec: key, value: vals }
      end
  end

  # rubocop: disable Metrics/AbcSize: Assignment Branch Condition
  # Create a hash, where there is an entry for each fieldable in event,
  # under the section name.
  #
  # @note this method is somewhat temporary; it will be replace when graphql
  # can resolve the event list page.
  def assemble_fieldables(hash)
    prefix = "#{self.class.to_s.downcase}_"
    fieldable_values.each do |value|
      section_name = value.form_field.form_section
      section_name = section_name[prefix.size, section_name.length]
      hash[section_name] ||= []
      hash[section_name] << {
        spec: { field_name: value.form_field.field_name },
        value: { value: value.value,
                 # TODO: need to fix this condition, perhaps take the if out
                 entity: if value.entity.is_a? FieldItem
                           {
                             color: value.entity.color,
                             sequence: value.entity.sequence,
                             label: value.entity.label,
                             i18n_key: value.entity.i18n_key
                           }
                         end,
                 entity_id: value.entity_id }
      }
    end
    # rubocop: enable Metrics/AbcSize: Assignment Branch Condition
  end

  # @param [String] field_name
  #   Name of the `FormField` for which to find `field_value` information
  #
  # @return [FieldValue]
  #   which should point to an `entity`
  #
  def field_value_entity(field_name)
    fieldable_values.find_by(form_field: form_field_entity(field_name))&.entity
  end

  # TODO: temporary method to make an indirection from field_value_entity to
  # accomodate for evaluation system owning the fields in the evaluation.
  #
  def field_value_evaluation(field_name, eval_system)
    fieldable_values.find_by(form_field: form_field_eval_system(field_name, eval_system))&.entity
  end

  # @param [String] field_name
  #   Name of the `FormField` for which to find `field_value` information
  #
  # @return [FormField]
  #   of `customer` in the current `app_model` whose name is `field_name`
  #
  def form_field_entity(field_name)
    customer.form_fields.find_by(app_model: self.class.to_s.underscore,
                                 field_name: field_name)
  end

  # TODO: temporary method to make an indirection from field_value_entity to
  # accomodate for evaluation system owning the fields in the evaluation.
  #
  def form_field_eval_system(field_name, eval_system)
    eval_system.form_fields.find_by(app_model: self.class.to_s.underscore,
                                    field_name: field_name)
  end

  # @param [String] field_name
  #   Name of the `FormField` for which to find `field_value` information
  #
  # @return [String]
  #   Value of the `field_value` belonging to the form_field named `field_name`
  #
  def field_value_value(field_name)
    entity_field_values = fieldable_values.select do |field_value|
      field_value.form_field.field_name == field_name
    end

    entity_field_values.first&.value
  end

  # TODO: (verify) this assumes that there is only one field_item per
  # form_field in the entity. Although this should be true, at the moment
  # there is no validation. This method might then return the wrong key.
  # TODO: Get rid of the rubocop problem.
  #
  # @param [String] field_name
  #   Name of the `FormField` for which we need to find `field_value` information
  #
  # @return [String]
  #   the `i18n_key` of the `field_item` pointed by the `field_value` belonging
  #   to the `form_field` named by `field_name`.
  #
  # @note Currently only useful for single selects, such as efficiency
  #   and criticality.
  #
  def field_item_key(field_name)
    # rubocop:disable Performance/Detect
    value = fieldable_values.select do |field_value|
      field_value.form_field.field_name == field_name
    end.first
    # rubocop:enable Performance/Detect

    value&.entity&.i18n_key
  end

  # TODO: this method originally assumes that form_fields are only owned by a
  # customer.
  # It calls the method which handles different possible form_field owners,
  # using the customer in the parameter list.
  #
  def required_fields?(section)
    required_fields_agnostic?(section, customer)
  end

  ##
  # Validates the specified form section by verifying that all related
  # mandatory fields are filled in. For example that there is a value
  # for the `title` field in the `description` section.
  #
  # This populates the validation `errors`.
  #
  # @param [String] form_field_owner
  #   The "owner" of the form_fields for the moment `customer` or
  #   `evaluation_system`.
  # @param [String] section
  #   Name of the form section without the `app_model` prefix.
  #   For example "description" (instead of "event_description")
  #
  # @return [Boolean] true if there is no validation errors for this section
  #
  def required_fields_agnostic?(section, form_field_owner)
    # TODO: this is an example of code so that tests pass. In the model test,
    # when checking for validations, all validatons are run but the object is
    # in memory and instantiated with new. One of the validations on creation
    # is required_fields. which needs a customer to find the form_fields.
    # In itself, this might be showing unnecessary coupling and this validation
    # should go elsewhere. To investigate.
    #
    return false unless form_field_owner

    # Early return if validations errors for this section are already set
    return false if errors.key?(section)

    # 1. Get the form_fields ids that are required for the section
    required_fields_ids = form_section_fields(section, form_field_owner).required.pluck(:id)

    # 2. Get the field_values form_fields id that are present
    present_fields_ids = fieldable_values.collect(&:form_field_id)

    # 3. Get the fields that are present
    present = required_fields_ids & present_fields_ids

    # 4. Get the missing by comparing which are missing in the second from the first
    missing = required_fields_ids - present

    return true if missing.empty?

    log_validation_errors(section, missing)
    false
  end

  def log_validation_errors(section, missing)
    # 5. Get the field_names of the form fields that should be present.
    missing_field_names = FormField.where(id: missing)
                                   .map { |field| field.label || field.default_label }
                                   .join(", ")

    # 6. Log the errors in the object errors array
    object_and_error_section = nil
    case self.class.to_s
    when "Evaluation", "MitigationStrategy"
      object_and_error_section = risk.errors[section]
    else
      object_and_error_section = errors[section]
    end

    object_and_error_section << "#{self.class} is missing the "\
                                "#{missing_field_names} field(s)."
  end

  ##
  # Return form fields related with the specified form section.
  #
  # @param section [String]
  #   Name of the form section without the `app_model` prefix.
  #   For example "description" (instead of "event_description")
  #
  # @return [ActiveRecord::Relation<FormField>]
  #
  def form_section_fields(section, form_field_owner)
    app_model = self.class.to_s.underscore
    form_section = "#{app_model}_#{section}"

    if FormField.form_sections.keys.exclude?(form_section)
      raise ArgumentError, "The form section `#{form_section}` does not exist."
    end

    form_field_owner.form_fields.send(form_section) # using the enum scope
  end

  # TODO: create methods dynamically using metaprogramming.
  def required_desc_fields?
    required_fields?("description")
  end

  def required_eval_fields?
    required_fields?("evaluation")
  end

  def required_analysis_fields?
    required_fields?("analysis")
  end

  def required_declared_events_fields?
    required_fields?("declared_events")
  end

  def required_synthesis_fields?
    required_fields?("synthesis")
  end

  def required_plan_fields?
    required_fields?("plan")
  end

  def form_field_object(field_name)
    customer.form_fields.find_by(field_name: field_name)
  end
end
