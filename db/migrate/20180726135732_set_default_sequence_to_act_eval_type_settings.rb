class SetDefaultSequenceToActEvalTypeSettings < ActiveRecord::Migration[4.2]
  def change
    CustomerSetting.all.each do |c|
      c.act_eval_types.each do |aet|
        if aet.respond_to?('set_sequence')
          aet.set_sequence
          aet.save
        end
      end
    end
  end
end
