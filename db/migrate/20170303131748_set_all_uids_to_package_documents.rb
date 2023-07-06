class SetAllUidsToPackageDocuments < ActiveRecord::Migration[4.2]
  def change
    PackageDocument.all.order(:id).each do |package_document|
      if !package_document.document.nil?
        package_document.update_attribute(:document_uid, package_document.document.uid)
        package_document.update_attribute(:groupdocument_uid, package_document.document.groupdocument.uid)
      end
    end
  end
end
