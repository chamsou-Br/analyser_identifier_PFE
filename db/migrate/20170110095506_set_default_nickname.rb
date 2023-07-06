class SetDefaultNickname < ActiveRecord::Migration[4.2]
  def change
    CustomerSetting.all.each do |setting|
      if setting[:nickname].nil?
        setting.update!(nickname: setting.customer.nickname)
      end
    end
  end
end
