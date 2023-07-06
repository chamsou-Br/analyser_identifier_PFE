class AddCampaignToCustomer < ActiveRecord::Migration[4.2]
  def change
  	add_column :customers, :campaign, :string
  end
end
