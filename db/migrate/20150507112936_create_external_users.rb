class CreateExternalUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :external_users do |t|

      t.integer :customer_id
      t.string :name

      t.timestamps null: false
    end
  end
end
