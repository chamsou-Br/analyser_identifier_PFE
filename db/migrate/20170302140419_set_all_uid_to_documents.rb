class SetAllUidToDocuments < ActiveRecord::Migration[4.2]
  def change
    i = 0
    Document.all.order(:id).each do |document|
      document.generate_uid(i)
      document.update_attribute(:uid, document.uid)
      i += 1
    end
  end
end
