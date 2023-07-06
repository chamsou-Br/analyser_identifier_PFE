class AddMetaEntityToActor < ActiveRecord::Migration[5.1]
  def change
    add_column :actors, :meta_entity, :string
  end
end
