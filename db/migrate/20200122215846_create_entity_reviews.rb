class CreateEntityReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :entity_reviews do |t|
      t.references :entity, polymorphic: true, null: false
      t.references :reviewer, foreign_key: { to_table: :users }, null: false
      t.boolean :approved, null: false
      t.datetime :reviewed_at, null: false
      t.boolean :active, null: false
      t.string :comment
      t.timestamps
    end
  end
end
