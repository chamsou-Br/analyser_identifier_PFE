class ChangeFieldTypeForCauseDescription < ActiveRecord::Migration[4.2]
  def change
    # EventSetting was migrated to the FormField solution
    #
    # settings_to_update = EventSetting.where({ field_name: 'cause_description' })
    #
    # settings_to_update.each do |s|
    #   s.field_type = EventSetting.field_types[:textarea]
    #   s.save
    # end
  end
end
