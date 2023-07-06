class AddFunctionPhoneServiceToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :function, :string
    add_column :users, :phone, :string
    add_column :users, :service, :string
  end
end
