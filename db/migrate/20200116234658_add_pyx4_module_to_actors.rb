class AddPyx4ModuleToActors < ActiveRecord::Migration[5.0]
  def change
    add_column :actors, :pyx4_module, :string
  end
end
