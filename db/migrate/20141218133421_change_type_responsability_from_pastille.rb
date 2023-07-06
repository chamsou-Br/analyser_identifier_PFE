class ChangeTypeResponsabilityFromPastille < ActiveRecord::Migration[4.2]
  def change
    Pastille.all.each do |pastille|
      label = 
        case pastille.responsability[0].upcase
          when "R", "A", "C", "I"
            pastille.responsability[0].upcase
          when "N"
            "0"
          when "U"
            "1"
          end
        pastille.update_attribute("responsability", pastille.element.graph.customer.settings.pastilles.where(:label => label).first.id)
    end

    change_column :pastilles, :responsability, :integer
    rename_column :pastilles, :responsability, :pastille_setting_id
  end
end
