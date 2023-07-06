class CreatePackageDocuments < ActiveRecord::Migration[4.2]
  def change
    create_table :package_documents do |t|
      t.belongs_to :package
      t.belongs_to :document
      t.belongs_to :groupdocument

      t.string   "title",                   limit: 255
      t.string   "url",                     limit: 2083
      t.string   "reference",               limit: 255
      t.string   "version",                 limit: 255
      t.string   "extension",               limit: 255
      t.string   "file",                    limit: 255
      t.string   "purpose",                 limit: 12000
      t.text     "domain",                  limit: 65535
      t.boolean  "confidential",                          default: false
      t.string   "news",                    limit: 765
      t.string   "print_footer",            limit: 100
      t.timestamps null: false
    end
  end
end
