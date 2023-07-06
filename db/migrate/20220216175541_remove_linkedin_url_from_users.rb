class RemoveLinkedinUrlFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :linkedin_url, :string
  end
end
