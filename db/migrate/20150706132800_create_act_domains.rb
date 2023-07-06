class CreateActDomains < ActiveRecord::Migration[4.2]
  def change
    create_table :act_domains do |t|
      t.integer :act_id
      t.integer :domain_id
    end
  end
end
