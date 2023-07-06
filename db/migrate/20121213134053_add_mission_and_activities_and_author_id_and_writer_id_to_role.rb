class AddMissionAndActivitiesAndAuthorIdAndWriterIdToRole < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :mission, :string, :limit => 765
    add_column :roles, :activities, :string, :limit => 765
    add_column :roles, :author_id, :integer
    add_column :roles, :writer_id, :integer
  end
end
