class SetCustomFieldToFalse < ActiveRecord::Migration[4.2]
  def change
    # EventSetting was migrated to the FormField solution
    #
    # EventSetting.all.each do |e|
    #   e.update(:custom_field => false)
    # end
  end
end
