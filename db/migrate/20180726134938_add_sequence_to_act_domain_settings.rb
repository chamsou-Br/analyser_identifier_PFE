class AddSequenceToActDomainSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :act_domain_settings, :sequence, :integer
  end
end
