class AddPreviousActSettings < ActiveRecord::Migration[4.2]
  def change
    # ActSetting was migrated to the FormField solution
    #
    # previous_act_settings_description = [
    #   {
    #     field_name: 'domains',
    #     mandatory: false,
    #     field_type: ActSetting.field_types[:multi_select]
    #   },
    #   {
    #     field_name: 'type',
    #     mandatory: true,
    #     field_type: ActSetting.field_types[:radio]
    #   }
    # ]
    #
    #
    # previous_act_settings_efficiency_evaluation = [
    #   {
    #     field_name: 'act_verif_type',
    #     mandatory: false,
    #     field_type: ActSetting.field_types[:radio]
    #   },
    #   {
    #     field_name: 'act_eval_type',
    #     mandatory: false,
    #     field_type: ActSetting.field_types[:radio]
    #   }
    # ]
    #
    # Customer.all.each do |c|
    #
    #   previous_act_settings_description.each do |pasd|
    #     event_settings = ActSetting.create!(
    #       :customer_id => c.id,
    #       :form_type => ActSetting.form_types[:act_description],
    #       :mandatory => pasd[:mandatory],
    #       :field_name => pasd[:field_name],
    #       :field_type => pasd[:field_type],
    #       :custom_field => false
    #     )
    #   end
    #
    #   previous_act_settings_efficiency_evaluation.each do |pasee|
    #     event_settings = ActSetting.create!(
    #       :customer_id => c.id,
    #       :form_type =>  ActSetting.form_types[:act_efficiency_evaluation],
    #       :mandatory => pasee[:mandatory],
    #       :field_name => pasee[:field_name],
    #       :field_type => pasee[:field_type],
    #       :custom_field => false
    #     )
    #   end
    # end
  end
end
