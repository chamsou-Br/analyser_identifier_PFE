class AddGenderStartedWorkDateMobilePhoneToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :gender, :string, :default => "Homme"
    add_column :users, :working_date, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :supervisor_id, :integer
    add_column :users, :linkedin_url, :string
  end
end
