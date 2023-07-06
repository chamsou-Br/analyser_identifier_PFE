class AddTitleToAudits < ActiveRecord::Migration[4.2]
  def change
    add_column :audits, :title, :string, limit: 250, after: :id
    Audit.where(title: ["", nil]).update_all(title: "untitled")
  end
end
