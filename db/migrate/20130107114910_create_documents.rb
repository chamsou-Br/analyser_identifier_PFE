class CreateDocuments < ActiveRecord::Migration[4.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :url
      t.string :reference
      t.integer :version
      t.string :extension

      t.timestamps
    end
  end
end
