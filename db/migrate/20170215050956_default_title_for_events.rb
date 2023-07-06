class DefaultTitleForEvents < ActiveRecord::Migration[4.2]
  def change
    Event.where(title: ["", nil]).update_all(title: "untitled")
  end
end
