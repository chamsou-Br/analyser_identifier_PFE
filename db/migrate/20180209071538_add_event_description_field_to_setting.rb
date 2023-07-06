 class AddEventDescriptionFieldToSetting < ActiveRecord::Migration[4.2]
  def change
    # EventSetting was migrated to the FormField solution
    #
    # default_field_to_add_for_event_description = [
    #   {
    #     field_name: 'internal_reference',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:text]
    #   },
    #   {
    #     field_name: 'occurrence_at',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:text]
    #   },
    #   {
    #     field_name: 'impacts',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:radio]
    #   },
    #   {
    #     field_name: 'attachments',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:file]
    #   },
    # ]
    #
    # default_field_to_rename = [
    #   {
    #     current_field_name: 'location',
    #     new_field_name: 'localisations',
    #   },
    #   {
    #     current_field_name: 'corrective_actions_taken',
    #     new_field_name: 'intervention',
    #   },
    # ]
    #
    # Customer.all.each do |c|
    #   default_field_to_add_for_event_description.each do |fed|
    #     event_settings = EventSetting.create!(
    #       :customer_id => c.id,
    #       :form_type => EventSetting.form_types[:event_description],
    #       :mandatory => fed[:mandatory],
    #       :field_name => fed[:field_name],
    #       :field_type => fed[:field_type],
    #       :custom_field => false,
    #     ).set_sequence
    #   end
    #
    #   default_field_to_rename.each do |ftr|
    #     event_setting = EventSetting.where(:customer_id => c.id, :field_name => ftr[:current_field_name]).take
    #     unless event_setting.nil?
    #       event_setting.update(:field_name => ftr[:new_field_name])
    #     end
    #   end
    # end
  end
end
