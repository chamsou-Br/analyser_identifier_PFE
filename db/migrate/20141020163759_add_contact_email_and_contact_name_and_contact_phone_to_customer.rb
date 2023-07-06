class AddContactEmailAndContactNameAndContactPhoneToCustomer < ActiveRecord::Migration[4.2]
  def up
    add_column :customers, :contact_email, :string
    add_column :customers, :contact_name, :string
    add_column :customers, :contact_phone, :string
    Customer.all.each do |customer|
      first_user = customer.users.first
      unless first_user.nil?
        customer.contact_email = first_user.email
        customer.contact_name = first_user.name.full
        customer.contact_phone = first_user.phone
        customer.save
      end
    end
  end
  def down
    remove_column :customers, :contact_email
    remove_column :customers, :contact_name
    remove_column :customers, :contact_phone
  end
end
