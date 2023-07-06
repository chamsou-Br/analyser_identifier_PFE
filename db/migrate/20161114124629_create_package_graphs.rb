class CreatePackageGraphs < ActiveRecord::Migration[4.2]
  def change
    create_table :package_graphs do |t|
      t.belongs_to :package
      t.belongs_to :graph
      t.belongs_to :groupgraph
      t.boolean :main, default: false
      t.string   "title",                   limit: 255
      t.string   "type",                    limit: 255
      t.integer  "level",                   limit: 4
      t.string   "state",                   limit: 255
      t.string   "reference",               limit: 255
      t.text     "domain",                  limit: 65535
      t.string   "version",                 limit: 255
      t.string   "purpose",                 limit: 12000
      t.boolean  "comment_index_int",       default: true
      t.string   "news",                    limit: 765
      t.boolean  "confidential",            default: false
      t.boolean  "tree",                    default: false
      t.string   "print_footer",            limit: 100
      t.timestamps null: false
    end
  end
end
