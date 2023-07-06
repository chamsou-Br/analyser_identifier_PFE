class SetDefaultSequenceToActTypeSettings < ActiveRecord::Migration[4.2]
  def change
    CustomerSetting.all.each do |c|
      c.act_types.each do |at|
        if at.respond_to?('set_sequence')
          at.set_sequence
          at.save
        end
      end
    end
  end
end
