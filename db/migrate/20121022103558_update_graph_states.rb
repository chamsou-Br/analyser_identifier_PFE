class UpdateGraphStates < ActiveRecord::Migration[4.2]
  def up
    Graph.where(:state => "creation").update_all(:state => 'new')
    Graph.where(:state => "updated").update_all(:state => 'updateInProgress')
    Graph.where(:state => "published").update_all(:state => 'applicable')
  end

  def down
    Graph.where(:state => "new").update_all(:state => 'creation')
    Graph.where(:state => "updateInProgress").update_all(:state => 'updated')
    Graph.where(:state => "applicable").update_all(:state => 'published')
  end
end
