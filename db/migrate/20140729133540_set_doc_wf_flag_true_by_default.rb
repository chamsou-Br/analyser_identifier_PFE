class SetDocWfFlagTrueByDefault < ActiveRecord::Migration[4.2]
  def change
  	change_column :flags, :doc_wf, :boolean, :default => true
  	Flag.all.each do |flag|
  		flag.doc_wf = true
      flag.save
  	end
  end
end
