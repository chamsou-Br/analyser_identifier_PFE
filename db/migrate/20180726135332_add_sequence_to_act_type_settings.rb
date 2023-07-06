class AddSequenceToActTypeSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :act_type_settings, :sequence, :integer
  end
end
