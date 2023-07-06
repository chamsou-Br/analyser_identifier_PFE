class ModifyDocumentPurposeDomainSizeLimit < ActiveRecord::Migration[4.2]
  def change
    change_table :documents do |t|
      t.change :purpose, :string, limit: 12000
      t.change :domain, :text, limit: 65535
    end
  end
end
