class SetDefaultTitleValueToActs < ActiveRecord::Migration[4.2]
  def change
    Act.where(title: ["", nil]).update_all(title: "untitled")
  end
end
