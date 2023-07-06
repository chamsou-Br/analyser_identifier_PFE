class CreateActDomainSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :act_domain_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.boolean :by_default, :default => false

      t.timestamps
    end
    CustomerSetting.all.each do |setting|
      setting.improver_act_domains.create!(by_default: true, color: "#e89c30", activated: true, label: "quality")
      setting.improver_act_domains.create!(by_default: true, color: "#f0bf72", activated: true, label: "security")
      setting.improver_act_domains.create!(by_default: true, color: "#f4d49e", activated: true, label: "environment")
    end
  end
end