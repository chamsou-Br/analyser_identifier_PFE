class DeleteInterventionFromEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :intervention, :string
  end
end
