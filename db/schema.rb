# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.




ActiveRecord::Schema[7.0].define(version: 2023_02_23_140124) do
  create_table "act_attachments", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "act_id"
    t.string "title"
    t.string "file"
    t.integer "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["act_id"], name: "index_act_attachments_on_act_id"
    t.index ["author_id"], name: "index_act_attachments_on_author_id"
  end

  create_table "act_domain_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sequence"
  end

  create_table "act_domains", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "act_id"
    t.integer "domain_id"
    t.index ["act_id", "domain_id"], name: "index_act_domains_on_act_id_and_domain_id"
    t.index ["act_id"], name: "index_act_domains_on_act_id"
    t.index ["domain_id"], name: "index_act_domains_on_domain_id"
  end

  create_table "act_eval_type_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sequence"
  end

  create_table "act_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.boolean "mandatory", default: true
    t.string "label", limit: 64
    t.boolean "active", default: true
    t.integer "sequence"
    t.string "field_name", null: false
    t.integer "form_type"
    t.boolean "custom_field", default: true
    t.integer "field_type", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "act_type_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sequence"
  end

  create_table "act_verif_type_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sequence"
  end

  create_table "action_plans", charset: "utf8", force: :cascade do |t|
    t.datetime "plan_frozen_date", precision: nil
    t.boolean "plan_frozen", default: false, null: false
    t.string "plannable_type"
    t.bigint "plannable_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["plannable_type", "plannable_id"], name: "index_action_plans_on_plannable_type_and_plannable_id"
  end

  create_table "action_plans_acts", id: false, charset: "utf8", force: :cascade do |t|
    t.bigint "act_id", null: false
    t.bigint "action_plan_id", null: false
    t.index ["act_id", "action_plan_id"], name: "index_action_plans_acts_on_act_id_and_action_plan_id", unique: true
    t.index ["action_plan_id", "act_id"], name: "index_action_plans_acts_on_action_plan_id_and_act_id"
  end

  create_table "actors", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "responsibility", null: false
    t.string "affiliation_type"
    t.integer "affiliation_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "module_level"
    t.string "model_level"
    t.string "app_level"
    t.index ["user_id", "responsibility", "module_level", "model_level", "affiliation_type", "affiliation_id"], name: "index_actors_on_all_fields", unique: true
  end

  create_table "acts", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "title", limit: 250, default: ""
    t.text "description"
    t.string "reference_prefix", default: ""
    t.string "reference", default: ""
    t.string "reference_suffix", default: ""
    t.integer "act_type_id"
    t.date "estimated_start_at"
    t.date "estimated_closed_at"
    t.integer "customer_id"
    t.integer "author_id"
    t.integer "owner_id"
    t.integer "state"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.date "real_started_at"
    t.date "real_closed_at"
    t.date "completed_at"
    t.integer "achievement", default: 0
    t.integer "act_verif_type_id"
    t.integer "act_eval_type_id"
    t.string "internal_reference"
    t.integer "efficiency"
    t.text "objective"
    t.text "check_result"
    t.string "cost", limit: 765
    t.index ["act_eval_type_id"], name: "index_acts_on_act_eval_type_id"
    t.index ["act_type_id"], name: "index_acts_on_act_type_id"
    t.index ["act_verif_type_id"], name: "index_acts_on_act_verif_type_id"
    t.index ["author_id"], name: "index_acts_on_author_id"
    t.index ["created_at"], name: "index_acts_on_created_at"
    t.index ["customer_id"], name: "index_acts_on_customer_id"
    t.index ["estimated_closed_at"], name: "index_acts_on_estimated_closed_at"
    t.index ["owner_id"], name: "index_acts_on_owner_id"
    t.index ["real_closed_at"], name: "index_acts_on_real_closed_at"
    t.index ["state"], name: "index_acts_on_state"
    t.index ["updated_at"], name: "index_acts_on_updated_at"
  end

  create_table "acts_events", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "act_id"
    t.integer "event_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["act_id", "event_id"], name: "index_acts_events_on_act_id_and_event_id"
    t.index ["act_id"], name: "index_acts_events_on_act_id"
    t.index ["event_id"], name: "index_acts_events_on_event_id"
  end

  create_table "acts_validators", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "act_id"
    t.integer "validator_id"
    t.integer "response"
    t.datetime "response_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "arrows", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.integer "from_id"
    t.integer "to_id"
    t.decimal "x", precision: 9, scale: 4
    t.decimal "y", precision: 9, scale: 4
    t.decimal "width", precision: 9, scale: 4
    t.decimal "height", precision: 9, scale: 4
    t.string "text"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "type"
    t.boolean "hidden", default: false
    t.text "comment"
    t.string "attachment"
    t.decimal "sx", precision: 9, scale: 4
    t.decimal "sy", precision: 9, scale: 4
    t.decimal "ex", precision: 9, scale: 4
    t.decimal "ey", precision: 9, scale: 4
    t.integer "font_size"
    t.string "color"
    t.string "grip_in"
    t.string "grip_out"
    t.boolean "centered", default: true
    t.string "title_color"
    t.string "title_fontfamily"
    t.string "stroke_color"
    t.integer "stroke_width"
    t.text "raw_comment", size: :medium
    t.string "comment_color", default: "#6F78B9"
    t.decimal "percent_from_start", precision: 9, scale: 4
    t.index ["from_id"], name: "index_arrows_on_from_id"
    t.index ["graph_id"], name: "index_arrows_on_graph_id"
    t.index ["to_id"], name: "index_arrows_on_to_id"
  end

  create_table "assessment_scale_ratings", charset: "utf8", force: :cascade do |t|
    t.string "color", null: false
    t.integer "value", null: false
    t.string "i18n_key"
    t.string "label"
    t.text "description"
    t.bigint "assessment_scale_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["assessment_scale_id"], name: "index_assessment_scale_ratings_on_assessment_scale_id"
  end



  create_table "assessment_scales", charset: "utf8", force: :cascade do |t|
    t.integer "impact_system_id"
    t.integer "likelihood_system_id"
    t.integer "threat_level_system_id"
    t.integer "scale_type"
    t.integer "evaluation_system_id"
    t.index ["evaluation_system_id"], name: "index_assessment_scales_on_evaluation_system_id"
    t.index ["impact_system_id"], name: "index_assessment_scales_on_impact_system_id"
    t.index ["likelihood_system_id"], name: "index_assessment_scales_on_likelihood_system_id"
    t.index ["threat_level_system_id"], name: "index_assessment_scales_on_threat_level_system_id"
  end

  create_table "audit_attachments", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "audit_id"
    t.string "title"
    t.string "file"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "author_id"
    t.index ["audit_id"], name: "index_audit_attachments_on_audit_id"
    t.index ["author_id"], name: "index_audit_attachments_on_author_id"
  end

  create_table "audit_element_subject_audit_events", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "audit_element_subject_id"
    t.integer "audit_event_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "audit_element_subjects", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "subject"
    t.integer "audit_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "audit_elements", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "audit_id"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "process_id"
    t.string "process_type"
    t.integer "audit_element_subject_id"
    t.string "subject"
    t.index ["audit_id"], name: "index_audit_elements_on_audit_id"
    t.index ["process_id", "process_type"], name: "index_audit_elements_on_process_id_and_process_type"
  end

  create_table "audit_events", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "audit_id"
    t.integer "event_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["audit_id"], name: "index_audit_events_on_audit_id"
    t.index ["event_id"], name: "index_audit_events_on_event_id"
  end

  create_table "audit_like_events", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "event_id"
    t.integer "audit_like_id"
    t.string "audit_like_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["audit_like_id", "audit_like_type"], name: "index_audit_like_events_on_audit_like_id_and_audit_like_type"
    t.index ["event_id", "audit_like_id", "audit_like_type"], name: "audit_event_link", unique: true
    t.index ["event_id"], name: "index_audit_like_events_on_event_id"
  end

  create_table "audit_participants", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "audit_element_id"
    t.boolean "auditor", default: false
    t.boolean "audited", default: false
    t.integer "participant_id"
    t.string "participant_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "domain_responsible", default: false
    t.index ["audit_element_id"], name: "index_audit_participants_on_audit_element_id"
    t.index ["participant_id", "participant_type"], name: "index_audit_participants_on_participant"
  end

  create_table "audit_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.boolean "mandatory", default: true
    t.string "label", limit: 64
    t.boolean "active", default: true
    t.integer "sequence"
    t.string "field_name", null: false
    t.integer "form_type"
    t.boolean "custom_field", default: true
    t.integer "field_type", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "audit_theme_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "audit_themes", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "audit_id"
    t.integer "theme_id"
    t.index ["audit_id"], name: "index_audit_themes_on_audit_id"
    t.index ["theme_id"], name: "index_audit_themes_on_theme_id"
  end

  create_table "audit_type_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "audits", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "title", limit: 250
    t.text "object"
    t.string "reference"
    t.text "synthesis"
    t.integer "customer_id"
    t.integer "audit_type_id"
    t.integer "owner_id"
    t.integer "organizer_id"
    t.date "estimated_start_at"
    t.date "real_start_at"
    t.date "estimated_closed_at"
    t.date "real_closed_at"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "internal_reference"
    t.integer "state"
    t.date "real_started_at"
    t.date "completed_at"
    t.index ["audit_type_id"], name: "index_audits_on_audit_type_id"
    t.index ["completed_at"], name: "index_audits_on_completed_at"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["customer_id"], name: "index_audits_on_customer_id"
    t.index ["estimated_closed_at"], name: "index_audits_on_estimated_closed_at"
    t.index ["organizer_id"], name: "index_audits_on_organizer_id"
    t.index ["owner_id"], name: "index_audits_on_owner_id"
    t.index ["state"], name: "index_audits_on_state"
    t.index ["updated_at"], name: "index_audits_on_updated_at"
  end

  create_table "colors", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "value"
    t.boolean "default", default: false
    t.boolean "active", default: false
    t.integer "position", null: false
  end

  create_table "contributables_contributors", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "contributor_id"
    t.integer "contributable_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "contributable_type"
    t.index ["contributable_id", "contributable_type"], name: "index_cc_cid_ctype"
    t.index ["contributor_id"], name: "index_contributables_contributors_on_contributor_id"
  end

  create_table "contributions", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.text "content"
    t.integer "contributable_id"
    t.string "contributable_type"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["contributable_id", "contributable_type"], name: "index_contributions_on_contributable_id_and_contributable_type"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "criticality_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "custom", default: false
    t.integer "sequence"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "activated", default: true
  end

  create_table "customer_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "logo"
    t.string "time_zone"
    t.string "print_footer", limit: 100
    t.boolean "allow_iframe", default: false
    t.integer "approved_read", default: 0
    t.boolean "owner_users_management", default: false
    t.integer "authentication_strategy", default: 0
    t.string "referent_contact"
    t.string "nickname"
    t.boolean "continuous_improvement_active", default: false
    t.integer "default_continuous_improvement_manager"
    t.integer "localisation_preference", default: 0, null: false
    t.integer "logo_usage", default: 0
    t.boolean "password_policy_enabled", default: false
    t.boolean "automatic_user_deactivation_enabled", default: false, null: false
    t.integer "deactivation_wait_period_days", default: 30, null: false
    t.index ["customer_id"], name: "index_customer_settings_on_customer_id"
  end

  create_table "customer_sso_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "sso_url"
    t.string "slo_url"
    t.integer "customer_setting_id"
    t.text "cert_x509"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email_key"
    t.string "firstname_key"
    t.string "lastname_key"
    t.string "idp_name"
    t.string "phone_key"
    t.string "service_key"
    t.string "function_key"
    t.string "mobile_phone_key"
    t.string "groups_key"
    t.string "roles_key"
  end

  create_table "customers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "freemium", default: true, null: false
    t.boolean "internal", default: false, null: false
    t.string "language", default: "fr"
    t.integer "max_power_user"
    t.integer "max_simple_user"
    t.boolean "reserved", default: false, null: false
    t.boolean "trial", default: false, null: false
    t.string "contact_email"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "campaign"
    t.string "comment", limit: 765
    t.integer "max_graphs_and_docs", default: -1
    t.boolean "deactivated", default: false, null: false
    t.datetime "deactivated_at", precision: nil
    t.boolean "newsletter", default: false
    t.string "sage_id"
    t.integer "internal_pu_count"
    t.index ["updated_at"], name: "index_customers_on_updated_at"
    t.index ["url"], name: "index_customers_on_url"
  end

  create_table "directories", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "customer_id"
    t.integer "author_id"
    t.index ["author_id"], name: "index_directories_on_author_id"
    t.index ["customer_id"], name: "index_directories_on_customer_id"
    t.index ["parent_id"], name: "index_directories_on_parent_id"
  end

  create_table "discussion_comments", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "thread_id", null: false
    t.integer "author_id", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_id"], name: "index_discussion_comments_on_author_id"
    t.index ["thread_id"], name: "index_discussion_comments_on_thread_id"
  end

  create_table "discussion_threads", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["record_type", "record_id"], name: "index_discussion_threads_on_record_type_and_record_id", unique: true
  end

  create_table "document_publishers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "document_id"
    t.integer "publisher_id"
    t.boolean "published"
    t.datetime "publish_date", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["document_id"], name: "index_document_publishers_on_document_id"
    t.index ["publisher_id"], name: "index_document_publishers_on_publisher_id"
  end

  create_table "documents", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "uid"
    t.string "title"
    t.string "url", limit: 990
    t.string "reference"
    t.string "version"
    t.string "extension"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "directory_id"
    t.integer "customer_id"
    t.string "file"
    t.integer "author_id"
    t.string "purpose", limit: 999
    t.string "state"
    t.text "domain"
    t.boolean "confidential", default: false
    t.integer "parent_id"
    t.integer "groupdocument_id"
    t.string "news", limit: 765
    t.integer "pilot_id"
    t.string "print_footer", limit: 100
    t.datetime "read_confirm_reminds_at", precision: nil
    t.integer "imported_package_id"
    t.string "imported_uid"
    t.string "imported_groupdocument_uid"
    t.index ["author_id"], name: "index_documents_on_author_id"
    t.index ["customer_id"], name: "index_documents_on_customer_id"
    t.index ["directory_id"], name: "index_documents_on_directory_id"
    t.index ["extension"], name: "index_documents_on_extension"
    t.index ["groupdocument_id"], name: "fk_documents_groupdocument"
    t.index ["parent_id"], name: "index_documents_on_parent_id"
    t.index ["reference"], name: "index_documents_on_reference"
    t.index ["state"], name: "index_documents_on_state"
    t.index ["title"], name: "index_documents_on_title"
    t.index ["updated_at"], name: "index_documents_on_updated_at"
  end

  create_table "documents_approvers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "document_id"
    t.integer "approver_id"
    t.boolean "approved", default: false, null: false
    t.string "comment", limit: 765
    t.boolean "historized", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["approver_id", "document_id"], name: "index_documents_approvers_on_approver_id_and_document_id"
    t.index ["approver_id"], name: "index_documents_approvers_on_approver_id"
    t.index ["document_id"], name: "index_documents_approvers_on_document_id"
  end

  create_table "documents_logs", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "document_id"
    t.string "action"
    t.string "comment", limit: 765
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["document_id"], name: "index_documents_logs_on_document_id"
    t.index ["user_id"], name: "index_documents_logs_on_user_id"
  end

  create_table "documents_verifiers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "document_id"
    t.integer "verifier_id"
    t.boolean "verified", default: false, null: false
    t.string "comment", limit: 765
    t.boolean "historized", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["document_id", "verifier_id"], name: "index_documents_verifiers_on_document_id_and_verifier_id"
    t.index ["document_id"], name: "index_documents_verifiers_on_document_id"
    t.index ["verifier_id"], name: "index_documents_verifiers_on_verifier_id"
  end

  create_table "documents_viewers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "document_id"
    t.integer "viewer_id"
    t.string "viewer_type"
    t.index ["document_id"], name: "index_documents_viewers_on_document_id"
    t.index ["viewer_id", "viewer_type"], name: "index_documents_viewers_on_viewer_id_and_viewer_type"
  end

  create_table "elements", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.string "type"
    t.integer "model_id"
    t.decimal "x", precision: 9, scale: 4
    t.decimal "y", precision: 9, scale: 4
    t.decimal "width", precision: 9, scale: 4
    t.decimal "height", precision: 9, scale: 4
    t.text "text"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "shape"
    t.integer "parent_role"
    t.integer "parent_id"
    t.text "comment"
    t.integer "leasher_id"
    t.integer "font_size"
    t.string "color"
    t.string "indicator"
    t.integer "zindex"
    t.string "titlePosition", default: "middle"
    t.boolean "bold", default: false
    t.boolean "italic", default: false
    t.boolean "underline", default: false
    t.integer "corner_radius"
    t.string "title_color"
    t.string "title_fontfamily"
    t.string "model_type"
    t.boolean "logo", default: false
    t.boolean "main_process", default: false
    t.integer "graph_image_id"
    t.text "raw_comment", size: :medium
    t.string "comment_color", default: "#6F78B9"
    t.text "indicator_comment"
    t.index ["graph_id"], name: "index_elements_on_graph_id"
    t.index ["leasher_id"], name: "index_elements_on_leasher_id"
    t.index ["model_id"], name: "index_elements_on_model_id"
    t.index ["model_type"], name: "index_elements_on_model_type"
    t.index ["parent_id"], name: "index_elements_on_parent_id"
    t.index ["parent_role"], name: "index_elements_on_parent_role"
    t.index ["type"], name: "index_elements_on_type"
    t.index ["zindex"], name: "index_elements_on_zindex"
  end

  create_table "entity_reviews", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "entity_type", null: false
    t.integer "entity_id", null: false
    t.integer "reviewer_id", null: false
    t.boolean "approved", null: false
    t.datetime "reviewed_at", precision: nil, null: false
    t.boolean "active", null: false
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["entity_type", "entity_id"], name: "index_entity_reviews_on_entity_type_and_entity_id"
    t.index ["reviewer_id"], name: "index_entity_reviews_on_reviewer_id"
  end

  create_table "evaluation_systems", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "customer_id"
    t.string "title", limit: 765
    t.integer "state"
    t.index ["customer_id"], name: "fk_rails_1054c3e588"
  end

  create_table "evaluations", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "risk_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "submitted_at", precision: nil
    t.integer "evaluation_system_id"
    t.index ["evaluation_system_id"], name: "index_evaluations_on_evaluation_system_id"
    t.index ["risk_id"], name: "index_evaluations_on_risk_id"
  end

  create_table "event_attachments", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "event_id"
    t.string "title"
    t.string "file"
    t.integer "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_id"], name: "index_event_attachments_on_author_id"
    t.index ["event_id"], name: "index_event_attachments_on_event_id"
  end

  create_table "event_cause_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "event_causes", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "event_id"
    t.integer "cause_id"
    t.index ["cause_id", "event_id"], name: "index_event_causes_on_cause_id_and_event_id"
    t.index ["cause_id"], name: "index_event_causes_on_cause_id"
    t.index ["event_id"], name: "index_event_causes_on_event_id"
  end

  create_table "event_custom_properties", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "event_id"
    t.integer "event_setting_id"
    t.string "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "event_domain_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sequence"
  end

  create_table "event_domains", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "event_id"
    t.integer "domain_id"
    t.index ["domain_id", "event_id"], name: "index_event_domains_on_domain_id_and_event_id"
    t.index ["domain_id"], name: "index_event_domains_on_domain_id"
    t.index ["event_id"], name: "index_event_domains_on_event_id"
  end

  create_table "event_setting_select_items", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "label", limit: 64
    t.integer "sequence"
    t.integer "event_setting_id"
    t.boolean "activated", default: true
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "event_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.boolean "mandatory", default: true
    t.string "label", limit: 64
    t.boolean "active", default: true
    t.integer "sequence"
    t.string "field_name", null: false
    t.integer "form_type"
    t.boolean "custom_field", default: true
    t.integer "field_type", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "event_type_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "label"
    t.string "color"
    t.boolean "activated"
    t.boolean "by_default", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sequence"
  end

  create_table "event_validators", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "validator_id"
    t.integer "event_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "response"
    t.datetime "response_at", precision: nil
    t.string "comment"
  end

  create_table "events", id: :integer, charset: "utf8", force: :cascade do |t|
    t.date "occurrence_at"
    t.integer "customer_id"
    t.integer "author_id"
    t.integer "owner_id"
    t.integer "criticality_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "state"
    t.string "reference"
    t.text "analysis"
    t.integer "event_type_id"
    t.string "consequence", limit: 765
    t.string "cost", limit: 765
    t.date "closed_at"
    t.string "internal_reference"
    t.index ["author_id"], name: "index_events_on_author_id"
    t.index ["created_at"], name: "index_events_on_created_at"
    t.index ["customer_id"], name: "index_events_on_customer_id"
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["owner_id"], name: "index_events_on_owner_id"
    t.index ["state"], name: "index_events_on_state"
    t.index ["updated_at"], name: "index_events_on_updated_at"
  end

  create_table "events_continuous_improvement_managers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "event_id"
    t.integer "continuous_improvement_manager_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "response"
    t.datetime "response_at", precision: nil
    t.string "comment"
  end

  create_table "events_risks", id: false, charset: "utf8", force: :cascade do |t|
    t.bigint "risk_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id", "risk_id"], name: "index_events_risks_on_event_id_and_risk_id"
    t.index ["risk_id", "event_id"], name: "index_events_risks_on_risk_id_and_event_id", unique: true
  end

  create_table "external_users", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_external_users_on_customer_id"
  end

  create_table "favorites", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "favorisable_id"
    t.string "favorisable_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["favorisable_id", "favorisable_type"], name: "index_favorites_on_favorisable_id_and_favorisable_type"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "field_items", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "form_field_id"
    t.integer "sequence", null: false
    t.string "label"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "integer_value"
    t.string "color"
    t.boolean "activated", default: true, null: false
    t.string "i18n_key"
    t.integer "parent_id"
    t.index ["form_field_id"], name: "index_field_items_on_form_field_id"
    t.index ["sequence", "form_field_id", "parent_id"], name: "index_field_items_on_sequence_and_form_field_id_and_parent_id", unique: true
  end

  create_table "field_values", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "fieldable_id"
    t.string "fieldable_type"
    t.text "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "form_field_id"
    t.integer "entity_id"
    t.string "entity_type"
    t.index ["form_field_id", "entity_id", "entity_type", "fieldable_id", "fieldable_type"], name: "form_field_links", unique: true
    t.index ["form_field_id"], name: "index_field_values_on_form_field_id"
  end

  create_table "flags", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "improver", default: false
    t.boolean "migration", default: false
    t.boolean "graph_steps", default: false
    t.boolean "sso", default: false
    t.boolean "renaissance", default: false
    t.boolean "store", default: false
    t.boolean "ldap", default: false
    t.boolean "risk_module", default: false
    t.index ["customer_id"], name: "index_flags_on_customer_id"
  end

  create_table "form_fields", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "app_model", null: false
    t.integer "form_section", null: false
    t.integer "field_type", null: false
    t.string "label"
    t.string "field_name", null: false
    t.boolean "custom"
    t.boolean "required", default: false
    t.integer "sequence", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "evaluation_system_id"
    t.integer "group"
    t.boolean "editable", default: true
    t.boolean "visible", default: true
    t.string "linkable_type"
    t.boolean "configurable", default: false
    t.text "description"
    t.index ["customer_id", "app_model", "evaluation_system_id", "field_name"], name: "index_form_fields_on_customer_app_model_eval_system_field_name", unique: true
    t.index ["customer_id", "app_model", "form_section", "evaluation_system_id", "sequence"], name: "unique_composite_index_on_form_fields", unique: true
    t.index ["customer_id", "app_model", "form_section"], name: "index_form_fields_on_customer_app_model_form_section"
    t.index ["evaluation_system_id"], name: "index_form_fields_on_evaluation_system_id"
  end

  create_table "general_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "general_setting_key"
    t.string "general_setting_value"
  end

  create_table "graph_backgrounds", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "file"
    t.string "color"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "pattern"
    t.string "pattern_fill_color"
    t.string "pattern_stroke_color"
    t.integer "opacity", default: 100
  end

  create_table "graph_images", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "title"
    t.string "file"
    t.integer "image_category_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "deactivated", default: false
  end

  create_table "graph_publishers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.integer "publisher_id"
    t.boolean "published"
    t.datetime "publish_date", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["graph_id"], name: "index_graph_publishers_on_graph_id"
    t.index ["publisher_id"], name: "index_graph_publishers_on_publisher_id"
  end

  create_table "graph_steps", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.text "set", size: :medium
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "graphs", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "uid"
    t.string "title", null: false
    t.string "type"
    t.integer "level"
    t.string "state"
    t.string "reference"
    t.text "domain"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "version"
    t.integer "model_id"
    t.string "purpose", limit: 999
    t.integer "directory_id"
    t.integer "customer_id"
    t.boolean "comment_index_int", default: true
    t.integer "author_id"
    t.integer "parent_id"
    t.string "news", limit: 765
    t.integer "groupgraph_id"
    t.boolean "confidential", default: false
    t.text "svg", size: :medium
    t.integer "pilot_id"
    t.boolean "tree", default: false
    t.string "print_footer", limit: 100
    t.datetime "read_confirm_reminds_at", precision: nil
    t.integer "graph_background_id"
    t.integer "imported_package_id"
    t.string "imported_uid"
    t.string "imported_groupgraph_uid"
    t.index ["author_id"], name: "index_graphs_on_author_id"
    t.index ["customer_id"], name: "index_graphs_on_customer_id"
    t.index ["directory_id"], name: "index_graphs_on_directory_id"
    t.index ["groupgraph_id"], name: "fk_graphs_groupgraph"
    t.index ["level"], name: "index_graphs_on_level"
    t.index ["model_id"], name: "index_graphs_on_model_id"
    t.index ["parent_id"], name: "index_graphs_on_parent_id"
    t.index ["pilot_id"], name: "index_graphs_on_pilot_id"
    t.index ["reference"], name: "index_graphs_on_reference"
    t.index ["state"], name: "index_graphs_on_state"
    t.index ["title"], name: "index_graphs_on_title"
    t.index ["updated_at"], name: "index_graphs_on_updated_at"
  end

  create_table "graphs_approvers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.integer "approver_id"
    t.boolean "approved", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "comment", limit: 765
    t.boolean "historized", default: false, null: false
    t.index ["approver_id", "graph_id"], name: "index_graphs_approvers_on_approver_id_and_graph_id"
    t.index ["approver_id"], name: "index_graphs_approvers_on_approver_id"
    t.index ["graph_id"], name: "index_graphs_approvers_on_graph_id"
  end

  create_table "graphs_logs", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.string "action"
    t.string "comment", limit: 765
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["graph_id"], name: "index_graphs_logs_on_graph_id"
    t.index ["user_id"], name: "index_graphs_logs_on_user_id"
  end

  create_table "graphs_roles", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.integer "graph_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["graph_id", "role_id"], name: "index_graphs_roles_on_graph_id_and_role_id"
    t.index ["graph_id"], name: "index_graphs_roles_on_graph_id"
    t.index ["role_id"], name: "index_graphs_roles_on_role_id"
  end

  create_table "graphs_verifiers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.integer "verifier_id"
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "comment", limit: 765
    t.boolean "historized", default: false, null: false
    t.index ["graph_id", "verifier_id"], name: "index_graphs_verifiers_on_graph_id_and_verifier_id"
    t.index ["graph_id"], name: "index_graphs_verifiers_on_graph_id"
    t.index ["verifier_id"], name: "index_graphs_verifiers_on_verifier_id"
  end

  create_table "graphs_viewers", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.integer "viewer_id"
    t.string "viewer_type"
    t.index ["graph_id"], name: "index_graphs_viewers_on_graph_id"
    t.index ["viewer_id", "viewer_type"], name: "index_graphs_viewers_on_viewer_id_and_viewer_type"
  end

  create_table "groupdocuments", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "uid"
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_groupdocuments_on_customer_id"
  end

  create_table "groupgraphs", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "uid"
    t.integer "customer_id"
    t.string "type"
    t.integer "level"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "root", default: false
    t.boolean "tree", default: false
    t.boolean "auto_role_viewer", default: false
    t.boolean "review_enable", default: false
    t.date "review_date"
    t.integer "review_reminder"
    t.index ["customer_id"], name: "index_groupgraphs_on_customer_id"
  end

  create_table "grouppackages", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "groups", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "customer_id"
    t.index ["customer_id"], name: "index_groups_on_customer_id"
    t.index ["title"], name: "index_groups_on_title"
    t.index ["updated_at"], name: "index_groups_on_updated_at"
  end

  create_table "image_categories", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "label"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "impactables_impacts", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "impactable_id"
    t.integer "impact_id"
    t.string "impact_type"
    t.string "impactable_type"
    t.string "title"
    t.index ["impact_id", "impact_type"], name: "index_impactables_impacts_on_impact_id_and_impact_type"
    t.index ["impactable_id", "impactable_type"], name: "index_impactables_impacts_on_impactable_id_and_impactable_type"
  end

  create_table "imported_packages", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_id"
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "lanes", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "graph_id"
    t.decimal "x", precision: 9, scale: 4
    t.decimal "width", precision: 9, scale: 4
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "element_id"
    t.index ["element_id"], name: "index_lanes_on_element_id"
    t.index ["graph_id"], name: "index_lanes_on_graph_id"
  end

  create_table "ldap_settings", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "host"
    t.integer "port", default: 389
    t.string "uid", default: "sAMAccountName"
    t.integer "encryption", default: 1
    t.string "base_dn"
    t.string "bind_dn"
    t.string "encrypted_password"
    t.string "encrypted_password_iv"
    t.integer "customer_setting_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email_key", default: "userPrincipalName"
    t.string "firstname_key", default: "givenName"
    t.string "lastname_key", default: "sn"
    t.string "phone_key"
    t.string "mobile_phone_key"
    t.string "function_key"
    t.string "service_key"
    t.string "groups_key"
    t.string "roles_key"
    t.string "server_name", default: "My LDAP server", null: false
    t.boolean "enabled", default: false, null: false
    t.string "filter", default: "", null: false
    t.index ["customer_setting_id"], name: "index_ldap_settings_on_customer_setting_id"
    t.index ["encrypted_password_iv"], name: "index_ldap_settings_on_encrypted_password_iv", unique: true
  end

  create_table "localisations", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "label"
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_localisations_on_customer_id"
    t.index ["label"], name: "index_localisations_on_label"
  end

  create_table "localisings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "localisable_id"
    t.string "localisable_type"
    t.integer "localisation_id"
    t.index ["localisable_id", "localisable_type"], name: "index_localisings_on_localisable_id_and_localisable_type"
    t.index ["localisation_id"], name: "index_localisings_on_localisation_id"
  end

  create_table "mitigation_strategies", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "risk_id"
    t.index ["risk_id"], name: "index_mitigation_strategies_on_risk_id"
  end

  create_table "models", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "level"
    t.boolean "landscape", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "customer_id"
    t.boolean "tree", default: false
    t.index ["customer_id"], name: "index_models_on_customer_id"
  end

  create_table "new_notifications", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "category"
    t.integer "from_id"
    t.integer "to_id"
    t.integer "entity_id"
    t.string "entity_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "checked_at", precision: nil
    t.integer "customer_id"
    t.text "notification_roles"
    t.datetime "mailed", precision: nil
    t.string "mail_delivered_frequency"
    t.index ["created_at"], name: "index_new_notifications_on_created_at"
    t.index ["customer_id"], name: "index_new_notifications_on_customer_id"
    t.index ["entity_id", "entity_type"], name: "index_new_notifications_on_entity_id_and_entity_type"
    t.index ["from_id"], name: "index_new_notifications_on_from_id"
    t.index ["to_id"], name: "index_new_notifications_on_to_id"
  end

  create_table "notifications", charset: "utf8", force: :cascade do |t|
    t.string "target_type"
    t.bigint "target_id"
    t.string "object_type"
    t.bigint "object_id"
    t.boolean "read", default: false, null: false
    t.text "metadata"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "sender_id"
    t.string "type"
    t.datetime "mailed_date", precision: nil
    t.integer "mailed_frequency"
    t.datetime "checked_at", precision: nil
    t.index ["object_type", "object_id"], name: "index_notifications_on_object_type_and_object_id"
    t.index ["read"], name: "index_notifications_on_read"
    t.index ["target_type", "target_id"], name: "index_notifications_on_target_type_and_target_id"
  end

  create_table "opportunities", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "state"
    t.string "internal_reference"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_opportunities_on_customer_id"
  end

  create_table "package_arrows", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_graph_id"
    t.integer "from_id"
    t.integer "to_id"
    t.decimal "x", precision: 9, scale: 4
    t.decimal "y", precision: 9, scale: 4
    t.decimal "width", precision: 9, scale: 4
    t.decimal "height", precision: 9, scale: 4
    t.string "text"
    t.string "type"
    t.boolean "hidden", default: false
    t.text "comment"
    t.string "attachment"
    t.decimal "sx", precision: 9, scale: 4
    t.decimal "sy", precision: 9, scale: 4
    t.decimal "ex", precision: 9, scale: 4
    t.decimal "ey", precision: 9, scale: 4
    t.integer "font_size"
    t.string "color"
    t.string "grip_in"
    t.string "grip_out"
    t.boolean "centered", default: true
    t.string "title_color"
    t.string "title_fontfamily"
    t.string "stroke_color"
    t.integer "stroke_width"
    t.text "raw_comment", size: :medium
    t.string "comment_color", default: "#6F78B9"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.decimal "percent_from_start", precision: 9, scale: 4
  end

  create_table "package_categories", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_id"
    t.integer "static_package_category_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "package_connections", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_id"
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "package_documents", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_id"
    t.integer "document_id"
    t.string "document_uid"
    t.integer "groupdocument_id"
    t.string "groupdocument_uid"
    t.string "title"
    t.string "url", limit: 999
    t.string "reference"
    t.string "version"
    t.string "extension"
    t.string "file"
    t.string "purpose", limit: 999
    t.text "domain"
    t.boolean "confidential", default: false
    t.string "news", limit: 765
    t.string "print_footer", limit: 100
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "package_elements", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_graph_id"
    t.string "type"
    t.integer "model_id"
    t.decimal "x", precision: 9, scale: 4
    t.decimal "y", precision: 9, scale: 4
    t.decimal "width", precision: 9, scale: 4
    t.decimal "height", precision: 9, scale: 4
    t.text "text"
    t.string "shape"
    t.integer "parent_role"
    t.integer "parent_id"
    t.text "comment"
    t.integer "leasher_id"
    t.integer "font_size"
    t.string "color"
    t.string "indicator"
    t.integer "zindex"
    t.string "titlePosition", default: "middle"
    t.boolean "bold", default: false
    t.boolean "italic", default: false
    t.boolean "underline", default: false
    t.integer "corner_radius"
    t.string "title_color"
    t.string "title_fontfamily"
    t.string "model_type"
    t.boolean "logo", default: false
    t.boolean "main_process", default: false
    t.integer "graph_image_id"
    t.text "raw_comment", size: :medium
    t.string "comment_color", default: "#6F78B9"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "indicator_comment"
  end

  create_table "package_graphs", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_id"
    t.integer "graph_id"
    t.string "graph_uid"
    t.integer "groupgraph_id"
    t.string "groupgraph_uid"
    t.boolean "main", default: false
    t.string "title"
    t.string "type"
    t.integer "level"
    t.string "state"
    t.string "reference"
    t.text "domain"
    t.string "version"
    t.string "purpose", limit: 999
    t.boolean "comment_index_int", default: true
    t.string "news", limit: 765
    t.boolean "confidential", default: false
    t.boolean "tree", default: false
    t.string "print_footer", limit: 100
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "package_lanes", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_graph_id"
    t.decimal "x", precision: 9, scale: 4
    t.decimal "width", precision: 9, scale: 4
    t.integer "element_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "package_pastilles", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "element_id"
    t.integer "role_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "label"
  end

  create_table "package_resources", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_id"
    t.integer "resource_id"
    t.string "title"
    t.string "url"
    t.string "resource_type"
    t.text "purpose"
    t.string "logo"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "package_roles", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "package_id"
    t.integer "role_id"
    t.string "title"
    t.string "type"
    t.string "mission", limit: 999
    t.string "activities", limit: 999
    t.string "purpose", limit: 999
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "packages", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "state"
    t.boolean "private"
    t.integer "customer_id"
    t.datetime "published_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "author_id"
    t.integer "grouppackage_id"
    t.integer "maingraphs_type"
    t.index ["customer_id"], name: "index_packages_on_customer_id"
  end

  create_table "pastille_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "color"
    t.string "desc_en"
    t.string "desc_fr"
    t.string "desc_es"
    t.string "desc_de"
    t.string "label", limit: 3
    t.boolean "activated"
    t.integer "customer_setting_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "custom", default: true
    t.index ["customer_setting_id"], name: "index_pastille_settings_on_customer_setting_id"
  end

  create_table "pastilles", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "element_id"
    t.integer "role_id"
    t.integer "pastille_setting_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["element_id"], name: "index_pastilles_on_element_id"
    t.index ["pastille_setting_id"], name: "index_pastilles_on_pastille_setting_id"
  end

  create_table "process_notifications", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.text "message"
    t.datetime "checked_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "title"
    t.string "notification_type", default: "information"
    t.index ["receiver_id"], name: "index_process_notifications_on_receiver_id"
    t.index ["sender_id"], name: "index_process_notifications_on_sender_id"
  end

  create_table "read_confirmations", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "process_type"
    t.integer "process_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "recordings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "reference"
    t.integer "customer_id"
    t.string "stock_tool"
    t.string "protect_tool"
    t.string "stock_time"
    t.string "destroy_tool"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["customer_id"], name: "index_recordings_on_customer_id"
  end

  create_table "reference_counters", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "event", default: 0
    t.integer "act", default: 0
    t.integer "customer_id"
    t.integer "audit", default: 0
    t.integer "risk", default: 0, null: false
    t.index ["customer_id", "act"], name: "index_reference_customer_action", unique: true
    t.index ["customer_id", "audit"], name: "index_reference_customer_audit", unique: true
    t.index ["customer_id", "event"], name: "index_reference_customer_event", unique: true
  end

  create_table "reference_settings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_setting_id"
    t.string "event_prefix"
    t.string "act_prefix"
    t.string "audit_prefix"
    t.index ["customer_setting_id"], name: "index_reference_settings_on_customer_setting_id"
  end

  create_table "reminders", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "remindable_id"
    t.string "remindable_type"
    t.string "job_id"
    t.string "reminder_type"
    t.date "occurs_at"
    t.date "reminds_at"
    t.integer "from_id"
    t.integer "to_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["from_id"], name: "index_reminders_on_from_id"
    t.index ["remindable_id", "remindable_type"], name: "index_reminders_on_remindable_id_and_remindable_type"
    t.index ["to_id"], name: "index_reminders_on_to_id"
  end

  create_table "resources", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.text "url"
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "author_id"
    t.string "resource_type"
    t.text "purpose"
    t.string "logo"
    t.boolean "deactivated", default: false
    t.integer "imported_package_id"
    t.index ["author_id"], name: "index_resources_on_author_id"
    t.index ["customer_id"], name: "index_resources_on_customer_id"
    t.index ["resource_type"], name: "index_resources_on_resource_type"
    t.index ["title"], name: "index_resources_on_title"
    t.index ["updated_at"], name: "index_resources_on_updated_at"
  end

  create_table "review_histories", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.date "review_date"
    t.integer "reviewer_id"
    t.integer "groupgraph_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "risk_impact_descriptions", charset: "utf8", force: :cascade do |t|
    t.text "text"
    t.bigint "impact_id"
    t.bigint "rating_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["impact_id"], name: "index_risk_impact_descriptions_on_impact_id"
    t.index ["rating_id"], name: "index_risk_impact_descriptions_on_rating_id"
  end

  create_table "risk_impacts", charset: "utf8", force: :cascade do |t|
    t.integer "evaluation_system_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "form_field_id"
    t.index ["evaluation_system_id"], name: "index_risk_impacts_on_evaluation_system_id"
    t.index ["form_field_id"], name: "index_risk_impacts_on_form_field_id"
  end

  create_table "risk_risks", charset: "utf8", force: :cascade do |t|
    t.integer "risk_id"
    t.integer "linked_risk_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["linked_risk_id"], name: "index_risk_risks_on_linked_risk_id"
    t.index ["risk_id", "linked_risk_id"], name: "index_risk_risks_on_risk_id_and_linked_risk_id", unique: true
    t.index ["risk_id"], name: "index_risk_risks_on_risk_id"
  end

  create_table "risks", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "state"
    t.string "internal_reference"
    t.index ["customer_id"], name: "index_risks_on_customer_id"
  end

  create_table "risks_roles", id: false, charset: "utf8", force: :cascade do |t|
    t.bigint "risk_id", null: false
    t.bigint "role_id", null: false
    t.index ["risk_id", "role_id"], name: "index_risks_roles_on_risk_id_and_role_id", unique: true
    t.index ["role_id", "risk_id"], name: "index_risks_roles_on_role_id_and_risk_id"
  end

  create_table "role_attachments", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.integer "author_id"
    t.string "title"
    t.string "file"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_id"], name: "index_role_attachments_on_author_id"
    t.index ["role_id"], name: "index_role_attachments_on_role_id"
  end

  create_table "roles", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "mission", limit: 999
    t.string "activities", limit: 999
    t.integer "author_id"
    t.integer "writer_id"
    t.integer "customer_id"
    t.string "purpose", limit: 999
    t.boolean "deactivated", default: false
    t.integer "imported_package_id"
    t.index ["author_id"], name: "index_roles_on_author_id"
    t.index ["customer_id"], name: "index_roles_on_customer_id"
    t.index ["title"], name: "index_roles_on_title"
    t.index ["type"], name: "index_roles_on_type"
    t.index ["updated_at"], name: "index_roles_on_updated_at"
    t.index ["writer_id"], name: "index_roles_on_writer_id"
  end

  create_table "roles_users", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "state_machines_state_changes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "from", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.string "comment"
    t.string "to", null: false
    t.string "transition_name", null: false
    t.index ["author_id"], name: "index_state_machines_state_changes_on_author_id"
    t.index ["entity_type", "entity_id"], name: "index_state_machines_state_changes_on_entity"
  end

  create_table "static_package_categories", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "family"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "store_connections", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "connection_id"
    t.boolean "enabled", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["connection_id"], name: "index_store_connections_on_connection_id"
    t.index ["customer_id", "connection_id"], name: "index_store_connections_on_customer_id_and_connection_id", unique: true
    t.index ["customer_id"], name: "index_store_connections_on_customer_id"
  end

  create_table "store_subscriptions", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscription_id"
    t.boolean "enabled", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["subscription_id"], name: "index_store_subscriptions_on_subscription_id"
    t.index ["user_id", "subscription_id"], name: "index_store_subscriptions_on_user_id_and_subscription_id", unique: true
    t.index ["user_id"], name: "index_store_subscriptions_on_user_id"
  end

  create_table "super_admins", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "lastname"
    t.string "firstname"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_super_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_super_admins_on_reset_password_token", unique: true
  end

  create_table "taggings", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tag_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type"
  end

  create_table "tags", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "customer_id"
    t.index ["customer_id"], name: "index_tags_on_customer_id"
    t.index ["label"], name: "index_tags_on_label"
  end

  create_table "task_flags", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "taskable_id"
    t.string "taskable_type"
    t.boolean "important"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tasks", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.text "description"
    t.text "result"
    t.boolean "completed"
    t.integer "act_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "timeline_acts", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "author_id"
    t.integer "act_id"
    t.text "object"
    t.string "comment"
    t.string "action"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "sparse", default: true
    t.index ["act_id"], name: "index_timeline_acts_on_act_id"
    t.index ["author_id"], name: "index_timeline_acts_on_author_id"
    t.index ["created_at"], name: "index_timeline_acts_on_created_at"
  end

  create_table "timeline_audits", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "author_id"
    t.integer "audit_id"
    t.text "object"
    t.string "comment"
    t.string "action"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "sparse", default: true
    t.index ["audit_id"], name: "index_timeline_audits_on_audit_id"
    t.index ["author_id"], name: "index_timeline_audits_on_author_id"
    t.index ["created_at"], name: "index_timeline_audits_on_created_at"
  end

  create_table "timeline_events", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "author_id"
    t.integer "event_id"
    t.text "object"
    t.string "comment", limit: 999
    t.string "action"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "sparse", default: true
    t.index ["author_id"], name: "index_timeline_events_on_author_id"
    t.index ["created_at"], name: "index_timeline_events_on_created_at"
    t.index ["event_id"], name: "index_timeline_events_on_event_id"
  end

  create_table "tolk_locales", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_tolk_locales_on_name", unique: true
  end

  create_table "tolk_phrases", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "key"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "tolk_translations", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "phrase_id"
    t.integer "locale_id"
    t.text "text"
    t.text "previous_text"
    t.boolean "primary_updated", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["phrase_id", "locale_id"], name: "index_tolk_translations_on_phrase_id_and_locale_id", unique: true
  end

  create_table "user_attachments", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "file"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.string "email"
    t.string "lastname"
    t.string "firstname"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "customer_id"
    t.string "function"
    t.string "phone"
    t.string "service"
    t.boolean "skip_homepage", default: false
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.string "gender", default: "man"
    t.datetime "working_date", precision: nil
    t.string "mobile_phone"
    t.integer "supervisor_id"
    t.boolean "deactivated", default: false
    t.string "profile_type", default: "user"
    t.string "language", default: "fr"
    t.string "avatar"
    t.string "improver_profile_type", default: "user"
    t.string "time_zone"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.string "mail_frequency", default: "real_time"
    t.integer "mail_weekly_day", default: 0
    t.integer "mail_locale_hour", default: 0
    t.boolean "owner", default: false
    t.string "emergency_token"
    t.datetime "emergency_sent_at", precision: nil
    t.boolean "skip_store_video", default: false
    t.datetime "last_access_to_store", precision: nil, default: "1970-01-01 00:00:00"
    t.datetime "current_access_to_store", precision: nil, default: "1970-01-01 00:00:00"
    t.boolean "events_manager", default: true
    t.boolean "actions_manager", default: true
    t.boolean "continuous_improvement_manager", default: false
    t.boolean "audits_organizer", default: true
    t.index ["current_sign_in_at"], name: "index_users_on_current_sign_in_at"
    t.index ["customer_id"], name: "index_users_on_customer_id"
    t.index ["firstname"], name: "index_users_on_firstname"
    t.index ["improver_profile_type"], name: "index_users_on_improver_profile_type"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id", "invited_by_type"], name: "index_users_on_invited_by_id_and_invited_by_type"
    t.index ["lastname"], name: "index_users_on_lastname"
    t.index ["profile_type"], name: "index_users_on_profile_type"
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["supervisor_id"], name: "index_users_on_supervisor_id"
  end

  create_table "users_groups", id: :integer, charset: "utf8", collation: "utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.index ["group_id", "user_id"], name: "index_users_groups_on_group_id_and_user_id"
    t.index ["group_id"], name: "index_users_groups_on_group_id"
    t.index ["user_id"], name: "index_users_groups_on_user_id"
  end

  create_table "versions", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.json "associations"
    t.datetime "created_at"
    t.string "event", null: false
    t.json "fields"
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.json "object"
    t.json "object_changes"
    t.string "whodunnit"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "assessment_scale_ratings", "assessment_scales"
  add_foreign_key "assessment_scales", "evaluation_systems"
  add_foreign_key "assessment_scales", "evaluation_systems", column: "impact_system_id"
  add_foreign_key "assessment_scales", "evaluation_systems", column: "likelihood_system_id"
  add_foreign_key "assessment_scales", "evaluation_systems", column: "threat_level_system_id"
  add_foreign_key "discussion_comments", "discussion_threads", column: "thread_id"
  add_foreign_key "entity_reviews", "users", column: "reviewer_id"
  add_foreign_key "evaluation_systems", "customers"
  add_foreign_key "evaluations", "evaluation_systems"
  add_foreign_key "evaluations", "risks"
  add_foreign_key "field_items", "form_fields"
  add_foreign_key "form_fields", "customers"
  add_foreign_key "form_fields", "evaluation_systems"
  add_foreign_key "mitigation_strategies", "risks"
  add_foreign_key "opportunities", "customers"
  add_foreign_key "packages", "customers"
  add_foreign_key "risk_impact_descriptions", "assessment_scale_ratings", column: "rating_id"
  add_foreign_key "risk_impact_descriptions", "risk_impacts", column: "impact_id"
  add_foreign_key "risk_impacts", "evaluation_systems"
  add_foreign_key "risk_impacts", "form_fields"
  add_foreign_key "risk_risks", "risks"
  add_foreign_key "risk_risks", "risks", column: "linked_risk_id"
  add_foreign_key "risks", "customers"
  add_foreign_key "role_attachments", "roles"
  add_foreign_key "role_attachments", "users", column: "author_id"
  add_foreign_key "state_machines_state_changes", "users", column: "author_id"
end
