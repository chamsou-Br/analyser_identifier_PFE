class UpdateRoleAndRelatedroleElementLink < ActiveRecord::Migration[4.2]
  def change
    Element.where("shape in ('role', 'relatedRole') AND model_id IS NOT NULL AND model_type IS NULL").update_all(model_type: "Role")
  end
end
