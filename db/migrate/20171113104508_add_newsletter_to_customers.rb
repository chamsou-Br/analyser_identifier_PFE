class AddNewsletterToCustomers < ActiveRecord::Migration[4.2]
  def change
    add_column :customers, :newsletter, :boolean, :default => false
  end
end
