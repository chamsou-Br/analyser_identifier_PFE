class AddStateToRisk < ActiveRecord::Migration[4.2]
  def change
    add_column :risks, :state, :string
  end
end
