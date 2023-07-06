class SetGraphContributionFlagTrueByDefault < ActiveRecord::Migration[4.2]
  def change
  	change_column :flags, :graph_contribution, :boolean, :default => true
  	Flag.all.each do |flag|
  		flag.graph_contribution = true
      flag.save
  	end
  end
end
