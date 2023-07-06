class SetDefaultSequenceToActDomainSettings < ActiveRecord::Migration[4.2]
  def change
    CustomerSetting.all.each do |c|
      c.improver_act_domains.each do |iad|
        if iad.respond_to?('set_sequence')
          iad.set_sequence
          iad.save
        end
      end
    end
  end
end
