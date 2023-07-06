class CreateFavorites < ActiveRecord::Migration[4.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.references :favorisable, polymorphic: true
      t.timestamps
    end
  end
end
