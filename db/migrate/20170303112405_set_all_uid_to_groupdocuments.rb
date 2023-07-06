class SetAllUidToGroupdocuments < ActiveRecord::Migration[4.2]
  def change
    i = 0
    Groupdocument.all.order(:id).each do |groupdocument|
      groupdocument.generate_uid(i)
      groupdocument.update_attribute(:uid, groupdocument.uid)
      i += 1
    end
  end
end
