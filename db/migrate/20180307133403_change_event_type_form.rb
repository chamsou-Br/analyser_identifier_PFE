class ChangeEventTypeForm < ActiveRecord::Migration[4.2]
  def change
    # EventSetting was migrated to the FormField solution
    #
    # EventSetting.where(:field_name => 'event_type').each do |e|
    #   e.update(:form_type => EventSetting.form_types[:event_analysis])
    #   e.update(:sequence => e.set_sequence(EventSetting.form_types[:event_analysis]))
    # end
  end
end
