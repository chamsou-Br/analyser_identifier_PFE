class AddModelTypeToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :model_type, :string
    Element.all.each do |el|
      if !el.model_id.nil?
        model_type  = case el.shape
                        when 'role', 'relatedRole'
                          'Role'
                        when 'resource'
                          'Resource'
                        when 'document'
                          'Document'
                        when 'recording'
                          'Recording'
                        else
                          'Groupgraph'
                      end
        el.update_attributes(:model_type => model_type)
      end
    end
  end
end
