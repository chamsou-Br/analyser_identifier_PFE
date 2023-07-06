class ChangeEventAnalysisFormFields < ActiveRecord::Migration[4.2]
  def change
    # EventSetting was migrated to the FormField solution
    #
    # default_field_to_rename = [
    #   {
    #     current_field_name: 'cause_description',
    #     new_field_name: 'analysis',
    #   },
    #   {
    #     current_field_name: 'criticality_level',
    #     new_field_name: 'criticality',
    #   },
    #   {
    #     current_field_name: 'event_domaines',
    #     new_field_name: 'domains',
    #   },
    #   {
    #     current_field_name: 'cause_type',
    #     new_field_name: 'causes',
    #   },
    #   {
    #     current_field_name: 'consequences',
    #     new_field_name: 'consequence',
    #   },
    #   {
    #     current_field_name: 'event_type',
    #     new_field_name: 'type',
    #   },
    # ]
    #
    # default_field_to_rename.each do |ftr|
    #   EventSetting.where(:field_name => ftr[:current_field_name]).update_all(field_name: ftr[:new_field_name])
    # end
  end
end
