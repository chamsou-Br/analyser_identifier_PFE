class AddLogoToResource < ActiveRecord::Migration[4.2]
  def change
    add_column :resources, :logo, :string
  end
end
