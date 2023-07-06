class AddActVerifTypeIdAndActEvalTypeIdToActs < ActiveRecord::Migration[4.2]
  def change
    add_column :acts, :act_verif_type_id, :integer
    add_column :acts, :act_eval_type_id, :integer
  end
end
