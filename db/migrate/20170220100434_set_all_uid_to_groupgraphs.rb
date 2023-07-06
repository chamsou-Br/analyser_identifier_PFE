class SetAllUidToGroupgraphs < ActiveRecord::Migration[4.2]
  def change
    i = 0
    Groupgraph.all.order(:id).each do |groupgraph|
      groupgraph.generate_uid(i)
      groupgraph.update_attribute(:uid, groupgraph.uid)
      i += 1
    end
  end
end
