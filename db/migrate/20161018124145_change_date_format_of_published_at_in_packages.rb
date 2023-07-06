class ChangeDateFormatOfPublishedAtInPackages < ActiveRecord::Migration[4.2]
  def up
    change_column :packages, :published_at, :datetime
  end

  def down
    change_column :packages, :published_at, :date
  end
end
