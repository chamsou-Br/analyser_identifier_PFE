class CreateFlags < ActiveRecord::Migration[4.2]
  def up
    create_table :flags do |t|
      t.belongs_to :customer
      t.boolean :doc_wf, :default => false

      t.timestamps
    end
    Customer.all.each do |customer|
      Flag.create!(:customer_id => customer.id)
    end
  end

  def down
    drop_table :flags
  end
end
