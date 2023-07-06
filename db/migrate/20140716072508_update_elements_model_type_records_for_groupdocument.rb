class UpdateElementsModelTypeRecordsForGroupdocument < ActiveRecord::Migration[4.2]
  def change
  	Element.all.each do |element|
      if element.model_type == "Document"
        element.model_type = "Groupdocument"
        element.save
      end
    end
  end
end
