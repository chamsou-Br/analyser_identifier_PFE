class CreateEventDomains < ActiveRecord::Migration[4.2]
  def change
    create_table :event_domains do |t|
      t.integer :event_id
      t.integer :domain_id
    end
  end
end
