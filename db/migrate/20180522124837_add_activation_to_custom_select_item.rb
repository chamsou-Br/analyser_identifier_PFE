class AddActivationToCustomSelectItem < ActiveRecord::Migration[4.2]
  def change
    # not used anymore
    # add_column :event_setting_select_items, :activated, :boolean, default: true, after: :event_setting_id
  end
end
