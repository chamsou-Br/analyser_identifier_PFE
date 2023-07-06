class UpdateElementsModelIdRecordsForGroupdocument < ActiveRecord::Migration[4.2]
  def change
  	Element.where(:model_type => "Groupdocument").each do |element|
      if Document.exists?(element.model_id)
        groupdocument_id = Document.find(element.model_id).groupdocument_id
        puts "--> updating element(id:#{element.id}) : change element.model_id from #{element.model_id} to #{groupdocument_id}..."
        element.model_id = groupdocument_id
        element.save
      end
    end
  end
end
