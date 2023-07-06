class AddIndexToActors < ActiveRecord::Migration[5.2]
  def change
    add_index :actors,
      [:user_id, :responsibility, :module_level, :model_level,
       :affiliation_type, :affiliation_id],
      unique: true,
      name: "index_actors_on_all_fields",
      length: { responsibility: 15, module_level: 15, model_level: 15,
                affiliation_type: 15 }
  end
end
