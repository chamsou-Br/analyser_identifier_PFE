class CreateRiskLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :risk_links do |t|
      t.integer :risk_id
      t.belongs_to :linkable, polymorphic: true
      t.timestamps null: false
    end
    add_index :risk_links, [:risk_id, :linkable_id, :linkable_type],
      unique: true,
      name: 'risk_links_to_all'
  end
end
