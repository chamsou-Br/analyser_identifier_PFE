class AddSubjectEventToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :subject_event, :boolean, :default => false
  end

end
