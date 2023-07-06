class AddSequenceToActEvalTypeSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :act_eval_type_settings, :sequence, :integer
  end
end
