class AddLogoToElement < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :logo, :boolean, default: false
  end
end
