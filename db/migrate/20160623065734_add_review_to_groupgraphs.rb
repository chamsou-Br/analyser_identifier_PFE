class AddReviewToGroupgraphs < ActiveRecord::Migration[4.2]
  def up
    add_column :groupgraphs, :review_enable, :boolean, :default => false
    add_column :groupgraphs, :review_date, :date
    add_column :groupgraphs, :review_reminder, :integer
  end

  def down
    remove_column :groupgraphs, :review_enable
    remove_column :groupgraphs, :review_date
    remove_column :groupgraphs, :review_reminder
  end
end
