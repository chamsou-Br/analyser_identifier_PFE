class ChangeDescriptionInTaskToText < ActiveRecord::Migration[5.2]
  def change
    change_column(:tasks, :description, :text)
    change_column(:tasks, :result, :text)
  end
end
