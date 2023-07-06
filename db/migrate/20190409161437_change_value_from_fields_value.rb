class ChangeValueFromFieldsValue < ActiveRecord::Migration[5.0]
  def change
    change_column :fields_values, :value, :text, limit: 65535
  end
end
