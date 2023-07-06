class AddEfficiencyToAct < ActiveRecord::Migration[4.2]
  def change
  	add_column :acts, :efficiency, :integer
  end
end
