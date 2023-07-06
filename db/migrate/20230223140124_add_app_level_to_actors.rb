class AddAppLevelToActors < ActiveRecord::Migration[5.2]
  def change
    add_column :actors, :app_level, :string
  end
end
