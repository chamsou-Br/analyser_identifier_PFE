class AddReadConfirmationToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :read_confirmation, :boolean, :default => false
  end
end
