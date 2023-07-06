class CreatePackageArrows < ActiveRecord::Migration[4.2]
  def change
    create_table :package_arrows do |t|
      t.integer  "package_graph_id",         limit: 4
      t.integer  "from_id",          limit: 4
      t.integer  "to_id",            limit: 4
      t.decimal  "x",                                 precision: 9, scale: 4
      t.decimal  "y",                                 precision: 9, scale: 4
      t.decimal  "width",                             precision: 9, scale: 4
      t.decimal  "height",                            precision: 9, scale: 4
      t.string   "text",             limit: 255
      t.string   "type",             limit: 255
      t.boolean  "hidden",                                                    default: false
      t.text     "comment",          limit: 65535
      t.string   "attachment",       limit: 255
      t.decimal  "sx",                                precision: 9, scale: 4
      t.decimal  "sy",                                precision: 9, scale: 4
      t.decimal  "ex",                                precision: 9, scale: 4
      t.decimal  "ey",                                precision: 9, scale: 4
      t.integer  "font_size",        limit: 4
      t.string   "color",            limit: 255
      t.string   "grip_in",          limit: 255
      t.string   "grip_out",         limit: 255
      t.boolean  "centered",                                                  default: true
      t.string   "title_color",      limit: 255
      t.string   "title_fontfamily", limit: 255
      t.string   "stroke_color",     limit: 255
      t.integer  "stroke_width",     limit: 4
      t.text     "raw_comment",      limit: 16777215
      t.string   "comment_color",    limit: 255,                              default: "#6F78B9"
      t.timestamps null: false
    end
  end
end
