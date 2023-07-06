class CreateActs < ActiveRecord::Migration[4.2]
  def change
    create_table :acts do |t|
      t.string :description, :limit => 765
      t.string :reference_prefix
      t.string :reference
      t.string :reference_suffix
      t.integer :act_type_id
      t.date :estimated_start_at
      t.date :estimated_closed_at
      t.integer :customer_id
      t.integer :author_id
      t.integer :owner_id
      t.integer :state, :default => 0

      t.timestamps
    end
  end
end
