class AddProfileTypeColumnToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :profile_type, :string, :default => "user"
  end
end
