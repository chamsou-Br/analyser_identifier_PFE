class ChangeFieldItemActivated < ActiveRecord::Migration[5.1]
  def up
    change_column_null(:field_items, :activated, false, true)
  end

  def down
    change_column_null(:field_items, :activated, true)
  end
end
