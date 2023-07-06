class RemoveSubjectEventFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :subject_event
  end
end
