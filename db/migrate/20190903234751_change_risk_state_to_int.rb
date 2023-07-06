class ChangeRiskStateToInt < ActiveRecord::Migration[5.0]
  def up
    change_column :risks, :state, :integer
  end

  def down
    change_column :risks, :state, :string
  end
end
