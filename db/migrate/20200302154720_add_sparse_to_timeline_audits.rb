class AddSparseToTimelineAudits < ActiveRecord::Migration[5.0]
  def change
    add_column :timeline_audits, :sparse, :boolean, default: true
  end
end
