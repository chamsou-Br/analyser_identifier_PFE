class SetDefaultSequenceToEventDomainsSetting < ActiveRecord::Migration[4.2]
  def change
    CustomerSetting.all.each do |c|
      c.improver_event_domains.each do |ied|
        ied.set_sequence
        ied.save
      end
    end
  end
end
