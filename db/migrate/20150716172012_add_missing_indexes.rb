class AddMissingIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :audits, :customer_id
    add_index :audits, :audit_type_id
    add_index :audits, :owner_id
    add_index :audits, :organizer_id
    add_index :arrows, :graph_id
    add_index :arrows, :from_id
    add_index :arrows, :to_id
    add_index :acts_events, :act_id
    add_index :acts_events, :event_id
    add_index :acts_events, [:act_id, :event_id]
    add_index :users_groups, :user_id
    add_index :users_groups, :group_id
    add_index :users_groups, [:group_id, :user_id]
    add_index :timeline_events, :author_id
    add_index :timeline_events, :event_id
    add_index :timeline_audits, :author_id
    add_index :timeline_audits, :audit_id
    add_index :timeline_acts, :author_id
    add_index :timeline_acts, :act_id
    add_index :taggings, [:taggable_id, :taggable_type]
    add_index :taggings, :tag_id
    add_index :act_domains, :act_id
    add_index :act_domains, :domain_id
    add_index :act_domains, [:act_id, :domain_id]
    add_index :tags, :customer_id
    add_index :act_attachments, :act_id
    add_index :act_attachments, :author_id
    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
    add_index :roles_users, [:role_id, :user_id]
    add_index :roles, :author_id
    add_index :roles, :writer_id
    add_index :roles, :customer_id
    add_index :favorites, [:favorisable_id, :favorisable_type]
    add_index :favorites, :user_id
    add_index :acts, :owner_id
    add_index :acts, :author_id
    add_index :acts, :customer_id
    add_index :acts, :act_type_id
    add_index :acts, :act_eval_type_id
    add_index :acts, :act_verif_type_id
    add_index :resources, :customer_id
    add_index :resources, :author_id
    add_index :reminders, [:remindable_id, :remindable_type]
    add_index :reminders, :from_id
    add_index :reminders, :to_id
    add_index :reference_settings, :customer_setting_id
    add_index :reference_counters, :customer_id
    add_index :recordings, :customer_id
    add_index :pastille_settings, :customer_setting_id
    add_index :pastilles, :element_id
    add_index :pastilles, :pastille_setting_id
    add_index :notifications, :receiver_id
    add_index :notifications, :sender_id
    add_index :new_notifications, :customer_id
    add_index :new_notifications, :from_id
    add_index :new_notifications, :to_id
    add_index :new_notifications, [:entity_id, :entity_type]
    add_index :models, :customer_id
    add_index :localisings, [:localisable_id, :localisable_type]
    add_index :localisings, :localisation_id
    add_index :localisations, :customer_id
    add_index :lanes, :graph_id
    add_index :lanes, :element_id
    add_index :impactables_impacts, [:impactable_id, :impactable_type]
    add_index :impactables_impacts, [:impact_id, :impact_type]
    add_index :groupgraphs, :customer_id
    add_index :groupdocuments, :customer_id
    add_index :groups, :customer_id
    add_index :graphs_viewers, [:viewer_id, :viewer_type]
    add_index :graphs_viewers, :graph_id
    add_index :documents_viewers, [:viewer_id, :viewer_type]
    add_index :documents_viewers, :document_id
    add_index :graphs_verifiers, :verifier_id
    add_index :graphs_verifiers, :graph_id
    add_index :graphs_verifiers, [:graph_id, :verifier_id]
    add_index :graphs_roles, :role_id
    add_index :graphs_roles, :graph_id
    add_index :graphs_roles, [:graph_id, :role_id]
    add_index :graphs_logs, :graph_id
    add_index :graphs_logs, :user_id
    add_index :graphs_approvers, :approver_id
    add_index :graphs_approvers, :graph_id
    add_index :graphs_approvers, [:approver_id, :graph_id]
    add_index :graph_publishers, :publisher_id
    add_index :graph_publishers, :graph_id
    add_index :graphs, :model_id
    add_index :graphs, :directory_id
    add_index :graphs, :customer_id
    add_index :graphs, :author_id
    add_index :graphs, :pilot_id
    add_index :graphs, :parent_id
    add_index :flags, :customer_id
    add_index :external_users, :customer_id
    add_index :event_domains, :event_id
    add_index :event_domains, :domain_id
    add_index :event_domains, [:domain_id, :event_id]
    add_index :event_causes, :event_id
    add_index :event_causes, :cause_id
    add_index :event_causes, [:cause_id, :event_id]
    add_index :event_attachments, :event_id
    add_index :event_attachments, :author_id
    add_index :events, :owner_id
    add_index :events, :author_id
    add_index :events, :customer_id
    add_index :events, :event_type_id
    add_index :elements, :graph_id
    add_index :documents_verifiers, :verifier_id
    add_index :documents_verifiers, :document_id
    add_index :documents_verifiers, [:document_id, :verifier_id]
    add_index :documents_logs, :document_id
    add_index :documents_logs, :user_id
    add_index :documents_approvers, :approver_id
    add_index :documents_approvers, :document_id
    add_index :documents_approvers, [:approver_id, :document_id]
    add_index :document_publishers, :publisher_id
    add_index :document_publishers, :document_id
    add_index :documents, :directory_id
    add_index :documents, :customer_id
    add_index :documents, :author_id
    add_index :documents, :parent_id
    add_index :directories, :parent_id
    add_index :directories, :customer_id
    add_index :directories, :author_id
    add_index :customer_settings, :customer_id
    add_index :contributions, [:contributable_id, :contributable_type]
    add_index :contributions, :user_id
    add_index :users, [:invited_by_id, :invited_by_type]
    add_index :users, :customer_id
    add_index :users, :supervisor_id
    add_index :contributables_contributors, :contributor_id
    add_index :contributables_contributors, [:contributable_id, :contributable_type], name: "index_cc_cid_ctype"
    add_index :audit_themes, :audit_id
    add_index :audit_themes, :theme_id
    add_index :audit_participants, [:participant_id, :participant_type]
    add_index :audit_participants, :audit_element_id
    add_index :audit_events, :audit_id
    add_index :audit_events, :event_id
    add_index :audit_elements, :audit_id
    add_index :audit_elements, [:process_id, :process_type]
    add_index :audit_attachments, :audit_id
    add_index :audit_attachments, :author_id
  end
end

