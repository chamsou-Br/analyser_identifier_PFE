class ChangeCriticalityLevelName < ActiveRecord::Migration[4.2]
  def change
    # EventSetting was migrated to the FormField solution
    #
    # EventSetting.where(:field_name => 'criticality_level').update_all(field_name: 'criticality')
  end
end
