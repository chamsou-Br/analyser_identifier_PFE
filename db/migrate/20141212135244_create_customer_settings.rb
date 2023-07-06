class CreateCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :customer_settings do |t|
      t.integer :customer_id

      t.timestamps
    end

    Customer.all.each do |c|
      CustomerSetting.create!(customer_id: c.id)
    end
  end
end
