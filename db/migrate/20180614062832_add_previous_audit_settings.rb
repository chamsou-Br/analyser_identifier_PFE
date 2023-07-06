class AddPreviousAuditSettings < ActiveRecord::Migration[4.2]
  def change
    # AuditSetting was migrated to the FormField solution
    #
    # previous_audit_settings_description = [
    #   {
    #     field_name: 'scope',
    #     mandatory: false,
    #     field_type: AuditSetting.field_types[:radio]
    #   },
    #   {
    #     field_name: 'type',
    #     mandatory: true,
    #     field_type: AuditSetting.field_types[:radio]
    #   },
    # ]
    #
    #
    #
    # Customer.all.each do |c|
    #
    #   previous_audit_settings_description.each do |pasd|
    #     event_settings = AuditSetting.create!(
    #       :customer_id => c.id,
    #       :form_type => AuditSetting.form_types[:audit_description],
    #       :mandatory => pasd[:mandatory],
    #       :field_name => pasd[:field_name],
    #       :field_type => pasd[:field_type],
    #       :custom_field => false
    #     )
    #   end
    # end
  end
end
