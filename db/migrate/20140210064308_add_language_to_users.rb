class AddLanguageToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :language, :string, :default => "fr"
  end
end
