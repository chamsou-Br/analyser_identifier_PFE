class AddImproverProfileTypeToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :improver_profile_type, :string, :default => "user"
  end
end
