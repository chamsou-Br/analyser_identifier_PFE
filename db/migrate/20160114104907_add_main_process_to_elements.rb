class AddMainProcessToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :main_process, :boolean, :default => false
  end
end
