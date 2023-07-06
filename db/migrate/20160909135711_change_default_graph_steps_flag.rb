class ChangeDefaultGraphStepsFlag < ActiveRecord::Migration[4.2]
  def change
  	change_column :flags, :graph_steps, :boolean, :default => false
  	Flag.all.each do |flag|
  		flag.graph_steps = false
      flag.save
  	end
  end
end
