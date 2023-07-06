class RemoveReadConfirmationFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :read_confirmation
  end
end
