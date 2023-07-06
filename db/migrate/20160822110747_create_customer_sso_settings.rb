class CreateCustomerSsoSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :customer_sso_settings do |t|
      t.string  :sso_url
      t.string  :slo_url
      t.integer :customer_id
      t.text    :cert_x509, :limit => 65535

      t.timestamps null: false
    end
  end
end
