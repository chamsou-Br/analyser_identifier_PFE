class AddImproverToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :improver, :boolean, :default => false
  end
end
