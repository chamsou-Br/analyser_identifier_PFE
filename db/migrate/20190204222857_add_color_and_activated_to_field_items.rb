class AddColorAndActivatedToFieldItems < ActiveRecord::Migration[4.2]
  def change
    add_column :field_items, :color, :string
    add_column :field_items, :activated, :boolean
  end
end
