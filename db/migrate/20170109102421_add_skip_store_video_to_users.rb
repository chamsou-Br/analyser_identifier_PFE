class AddSkipStoreVideoToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :skip_store_video, :boolean, default: false
  end
end
