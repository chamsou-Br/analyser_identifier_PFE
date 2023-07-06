class SetDefaultSequenceToActVerifTypeSettings < ActiveRecord::Migration[4.2]
  def change
    CustomerSetting.all.each do |c|
      c.act_verif_types.each do |avt|
        if avt.respond_to?('set_sequence')
          avt.set_sequence
          avt.save
        end
      end
    end
  end
end
