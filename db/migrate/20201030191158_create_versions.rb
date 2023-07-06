# frozen_string_literal: true

# This migration creates the `versions` table use by `paper_trail`.
class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    # Character set and collation are provided by `paper_trail`
    create_table :versions, { options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" } do |t|
      t.json     :associations
      t.datetime :created_at, precision: 6
      t.string   :event, null: false
      t.json     :fields
      # Type and ID limitations are provided by `paper_trail`
      t.string   :item_type, limit: 191, null: false
      t.integer  :item_id, limit: 8, null: false
      t.json     :object
      t.json     :object_changes
      t.string   :whodunnit
    end

    add_index :versions, %i[item_type item_id]
  end
end
