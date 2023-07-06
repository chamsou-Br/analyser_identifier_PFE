class SetAllFreemiumDeactivatedAt < ActiveRecord::Migration[4.2]
  def change
    Customer.where(:freemium => true, :deactivated_at => nil, :deactivated => false).each do |customer|
      customer.update_attribute(:deactivated_at, customer.created_at + 30.days)
    end
  end
end
