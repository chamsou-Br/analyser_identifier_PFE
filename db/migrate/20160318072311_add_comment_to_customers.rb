class AddCommentToCustomers < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :comment, :string, :limit => 765
  end
end
