class AddSequenceToEventTypeSettings < ActiveRecord::Migration[4.2]
  def up
    add_column :event_type_settings, :sequence, :integer

    CustomerSetting.find_each do |setting|
      setting.improver_types.each_with_index do |type, i|
        type.update(sequence: i.next)
      end
    end
  end

  def down
    remove_column :event_type_settings, :sequence
  end
end
