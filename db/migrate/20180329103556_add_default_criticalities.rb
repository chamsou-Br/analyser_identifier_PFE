class AddDefaultCriticalities < ActiveRecord::Migration[4.2]
  def change
    default_criticalities = [
      {
        label: 'major',
        color: '#b72025',
        sequence: 1
      },
      {
        label: 'important',
        color: '#ec9822',
        sequence: 2
      },
      {
        label: 'notable',
        color: '#ffecb2',
        sequence: 3
      },
      {
        label: 'minor',
        color: '#cfd8dc',
        sequence: 4
      },
    ]

    # replaced by data_migration:predef_formfield:populate_default_fields
    #
    # CustomerSetting.all.each do |c|
    #   default_criticalities.each do |dc|
    #     criticality = CriticalitySetting.new(dc)
    #     criticality.customer_setting_id = c.id
    #     criticality.save
    #   end
    # end
  end
end
