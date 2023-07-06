class AddSequenceToActVerifTypeSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :act_verif_type_settings, :sequence, :integer
  end
end
