class AddConcernToRole < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :concern, :boolean, :default => false
  end
end
