class AddLanguageToCustomer < ActiveRecord::Migration[4.2]
  def up
    add_column :customers, :language, :string, :default => 'fr'
  end

  def down
    remove_column :customers, :language
  end
end