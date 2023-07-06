class CreatePackageElements < ActiveRecord::Migration[4.2]
  def change
    create_table :package_elements do |t|
      t.integer  "package_graph_id", limit: 4
      t.string   "type",             limit: 255
      t.integer  "model_id",         limit: 4
      t.decimal  "x",                precision: 9, scale: 4
      t.decimal  "y",                precision: 9, scale: 4
      t.decimal  "width",            precision: 9, scale: 4
      t.decimal  "height",           precision: 9, scale: 4
      t.text     "text",             limit: 65535
      t.string   "shape",            limit: 255
      t.integer  "parent_role",      limit: 4
      t.integer  "parent_id",        limit: 4
      t.text     "comment",          limit: 65535
      t.integer  "leasher_id",       limit: 4
      t.integer  "font_size",        limit: 4
      t.string   "color",            limit: 255
      t.string   "indicator",        limit: 255
      t.integer  "zindex",           limit: 4
      t.string   "titlePosition",    limit: 255, default: "middle"
      t.boolean  "bold",             default: false
      t.boolean  "italic",           default: false
      t.boolean  "underline",        default: false
      t.integer  "corner_radius",    limit: 4
      t.string   "title_color",      limit: 255
      t.string   "title_fontfamily", limit: 255
      t.string   "model_type",       limit: 255
      t.boolean  "logo",             default: false
      t.boolean  "main_process",     default: false
      t.integer  "graph_image_id",   limit: 4
      t.text     "raw_comment",      limit: 16777215
      t.string   "comment_color",    limit: 255, default: "#6F78B9"
      t.timestamps null: false
    end
  end
end
