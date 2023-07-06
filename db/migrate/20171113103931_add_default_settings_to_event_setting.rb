class AddDefaultSettingsToEventSetting < ActiveRecord::Migration[4.2]
  def change
    # EventSetting was migrated to the FormField solution
    #
    # default_field_to_add_for_event_description = [
    #   {
    #     field_name: 'title',
    #     mandatory: true,
    #     field_type: EventSetting.field_types[:text]
    #   },
    #   {
    #     field_name: 'reference',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:text]
    #   },
    #   {
    #     field_name: 'event_type',
    #     mandatory: true,
    #     field_type: EventSetting.field_types[:radio]
    #   },
    #   {
    #     field_name: 'description',
    #     mandatory: true,
    #     field_type: EventSetting.field_types[:textarea]
    #   },
    #   {
    #     field_name: 'corrective_actions_taken',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:text]
    #   },
    #   {
    #     field_name: 'location',
    #     mandatory: true,
    #     field_type: EventSetting.field_types[:radio]
    #   }
    # ]
    #
    #
    # default_field_to_add_for_event_analysis = [
    #   {
    #     field_name: 'event_domaines',
    #     mandatory: true,
    #     field_type: EventSetting.field_types[:radio]
    #   },
    #   {
    #     field_name: 'criticality_level',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:radio]
    #   },
    #   {
    #     field_name: 'cause_description',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:radio]
    #   },
    #   {
    #     field_name: 'cause_type',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:text]
    #   },
    #   {
    #     field_name: 'consequences',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:text]
    #   },
    #   {
    #     field_name: 'cost',
    #     mandatory: false,
    #     field_type: EventSetting.field_types[:text]
    #   }
    # ]
    #
    # Customer.all.each do |c|
    #   field_rank_event_description = 0
    #   field_rank_event_analysis = 0
    #
    #   default_field_to_add_for_event_description.each do |fed|
    #     field_rank_event_description += 1
    #     event_settings = EventSetting.create!(
    #       :customer_id => c.id,
    #       :form_type => EventSetting.form_types[:event_description],
    #       :mandatory => fed[:mandatory],
    #       :field_name => fed[:field_name],
    #       :sequence => field_rank_event_description,
    #       :field_type => fed[:field_type]
    #     )
    #   end
    #
    #   default_field_to_add_for_event_analysis.each do |fea|
    #     field_rank_event_analysis += 1
    #     event_settings = EventSetting.create!(
    #       :customer_id => c.id,
    #       :form_type =>  EventSetting.form_types[:event_analysis],
    #       :mandatory => fea[:mandatory],
    #       :field_name => fea[:field_name],
    #       :sequence => field_rank_event_analysis,
    #       :field_type => fea[:field_type]
    #     )
    #   end
    # end
  end
end
