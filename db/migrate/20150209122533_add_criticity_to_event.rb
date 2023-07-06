class AddCriticityToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :criticity, :integer
  end
end
