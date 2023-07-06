class ChangeNameOfValueInFieldItem < ActiveRecord::Migration[5.0]
  def change
    rename_column :field_items, :value, :integer_value
  end
end
