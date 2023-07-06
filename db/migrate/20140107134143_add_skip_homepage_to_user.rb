class AddSkipHomepageToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :skipHomepage, :boolean, :default => false
  end
end
