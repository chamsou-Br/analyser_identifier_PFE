class CreateGroupdocuments < ActiveRecord::Migration[4.2]
  def change
    create_table :groupdocuments do |t|
      t.integer :customer_id

      t.timestamps
    end

    add_column :documents, :parent_id, :integer

    add_column :documents, :groupdocument_id, :integer
    Document.unscoped.each do |document|
      document.groupdocument = Groupdocument.create(:customer_id => document.customer_id)
      document.save
    end

  end
end
