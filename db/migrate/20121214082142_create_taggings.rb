class CreateTaggings < ActiveRecord::Migration[4.2]
  def change
  	drop_table :graphs_tags
    create_table :taggings do |t|
      t.integer :taggable_id
      t.string  :taggable_type
      t.integer :tag_id

      t.timestamps
    end
  end
end
