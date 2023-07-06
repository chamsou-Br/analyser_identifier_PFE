class AddOrderIndex < ActiveRecord::Migration[4.2]
  def change
    add_index :acts, :created_at
    add_index :acts, :updated_at
    add_index :acts, :real_closed_at
    add_index :acts, :estimated_closed_at

    add_index :events, :created_at
    add_index :events, :updated_at

    add_index :audits, :created_at
    add_index :audits, :updated_at
    add_index :audits, :completed_at
    add_index :audits, :estimated_closed_at

    add_index :users, :current_sign_in_at
    add_index :users, :lastname
    add_index :users, :firstname
    add_index :users, :profile_type
    add_index :users, :improver_profile_type

    add_index :documents, :title
    add_index :documents, :reference
    add_index :documents, :updated_at
    add_index :documents, :extension

    add_index :elements, :zindex

    add_index :graphs, :level
    add_index :graphs, :title
    add_index :graphs, :reference
    add_index :graphs, :updated_at

    add_index :groups, :title
    add_index :groups, :updated_at

    add_index :localisations, :label

    add_index :tags, :label

    add_index :timeline_acts, :created_at
    add_index :timeline_audits, :created_at
    add_index :timeline_events, :created_at

    add_index :new_notifications, :created_at

    add_index :customers, :updated_at
    add_index :customers, :url

    add_index :resources, :title
    add_index :resources, :resource_type
    add_index :resources, :updated_at


    add_index :roles, :title
    add_index :roles, :type
    add_index :roles, :updated_at

  end
end
