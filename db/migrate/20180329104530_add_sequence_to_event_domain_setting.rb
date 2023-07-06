class AddSequenceToEventDomainSetting < ActiveRecord::Migration[4.2]
  def change
    add_column :event_domain_settings, :sequence, :integer
  end
end
