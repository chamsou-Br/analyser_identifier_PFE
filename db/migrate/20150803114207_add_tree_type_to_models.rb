class AddTreeTypeToModels < ActiveRecord::Migration[4.2]
  def change
    add_column :models, :tree, :boolean, :default => false
    Customer.all.each do |customer|
      customer.models.create!(:type => 'process', :level => 3, :name => I18n.t('model.name.process3tree'), :landscape => false, :tree => true)
    end
  end
end
