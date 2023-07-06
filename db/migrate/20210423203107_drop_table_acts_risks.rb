class DropTableActsRisks < ActiveRecord::Migration[5.1]
  def change
    drop_join_table :acts, :risks
  end
end
