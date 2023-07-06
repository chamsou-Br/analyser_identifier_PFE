class FixEventCriticalitiesByCustomer < ActiveRecord::Migration[4.2]
  def change
    default_criticalities = [
      {
        label: 'major',
        color: '#b72025'
      },
      {
        label: 'important',
        color: '#ec9822'
      },
      {
        label: 'notable',
        color: '#ffecb2'
      },
      {
        label: 'minor',
        color: '#cfd8dc'
      },
    ]

    Event.all.each do |e|
      next if e.criticality.blank?
      criticality_label = CriticalitySetting.find(e.criticality)[:label]
      fixed_criticality = e.customer.settings.criticality_levels.where(label: criticality_label).first[:id]

      e.update_attribute(:criticality, fixed_criticality)
    end
  end
end
