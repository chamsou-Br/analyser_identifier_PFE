class ChangeObjectSynthesisMaxLength < ActiveRecord::Migration[4.2]
  def up
    change_column :audits, :object, :string, :limit => 765
    change_column :audits, :synthesis, :string, :limit => 765
  end

  def down
  end
end
