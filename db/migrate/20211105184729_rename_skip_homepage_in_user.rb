class RenameSkipHomepageInUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :skipHomepage, :skip_homepage
  end
end
