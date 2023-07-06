class AllowNilEntityTypeforActors < ActiveRecord::Migration[5.0]
  def change
    change_column_null :actors, :entity_type, true
  end
end
