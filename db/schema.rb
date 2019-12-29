# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_29_011502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties_jsonb_path_ops", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_messages", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.text "to"
    t.string "mailer"
    t.text "subject"
    t.datetime "sent_at"
    t.index ["user_type", "user_id"], name: "index_ahoy_messages_on_user_type_and_user_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "authorizations", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authorized_hosts", force: :cascade do |t|
    t.integer "device_id"
    t.string "name"
    t.string "address_mac"
    t.string "address_ipv4"
    t.string "address_ipv6"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "build_providers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "url"
    t.string "server"
    t.string "job"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mode"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64
    t.string "name"
    t.boolean "hidden"
    t.string "email"
    t.string "phone"
    t.text "notes"
    t.integer "user_id"
    t.integer "group_id"
    t.uuid "uuid"
    t.index ["code"], name: "index_contacts_on_code"
    t.index ["group_id"], name: "index_contacts_on_group_id"
    t.index ["hidden"], name: "index_contacts_on_hidden"
    t.index ["name"], name: "index_contacts_on_name"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "device_builds", force: :cascade do |t|
    t.integer "build_provider_id"
    t.integer "device_id"
    t.integer "device_type_id"
    t.string "title"
    t.string "body"
    t.string "url"
    t.integer "build_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_properties", id: :serial, force: :cascade do |t|
    t.integer "device_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "device_property_type_id"
    t.integer "device_property_option_id"
    t.index ["device_id"], name: "index_device_properties_on_device_id"
  end

  create_table "device_property_options", force: :cascade do |t|
    t.integer "device_property_type_id"
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_property_types", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "description"
    t.integer "value_type"
    t.text "config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_types", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64
    t.string "name"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "build_provider_id"
    t.text "config"
    t.text "postbuild"
    t.text "prebuild"
    t.index ["code"], name: "index_device_types_on_code"
    t.index ["name"], name: "index_device_types_on_name"
  end

  create_table "devices", id: :serial, force: :cascade do |t|
    t.integer "node_id"
    t.string "name"
    t.integer "device_type_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.index ["device_type_id"], name: "index_devices_on_device_type_id"
    t.index ["name"], name: "index_devices_on_name"
    t.index ["node_id"], name: "index_devices_on_node_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.string "name"
    t.text "description"
    t.string "action_url"
    t.boolean "action_priority"
    t.string "action_text"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "splash_position"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "uuid"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64
    t.string "name"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.index ["code"], name: "index_groups_on_code", unique: true
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "groups_users", id: :serial, force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
  end

  create_table "interfaces", id: :serial, force: :cascade do |t|
    t.integer "device_id"
    t.string "code"
    t.string "name"
    t.integer "network_id"
    t.text "body"
    t.string "address_ipv4"
    t.string "address_ipv6"
    t.string "address_mac"
    t.decimal "latitude"
    t.decimal "longitude"
    t.decimal "altitude"
    t.string "essid"
    t.string "security_psk"
    t.string "channel"
    t.decimal "tx_power"
    t.decimal "rx_sensitivity"
    t.decimal "cable_loss"
    t.decimal "antenna_gain"
    t.decimal "beamwidth_h"
    t.decimal "beamwidth_v"
    t.decimal "azimuth"
    t.decimal "elevation"
    t.string "polarity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.index ["code"], name: "index_interfaces_on_code"
    t.index ["device_id"], name: "index_interfaces_on_device_id"
    t.index ["name"], name: "index_interfaces_on_name"
    t.index ["network_id"], name: "index_interfaces_on_network_id"
  end

  create_table "mailkick_opt_outs", force: :cascade do |t|
    t.string "email"
    t.string "user_type"
    t.bigint "user_id"
    t.boolean "active", default: true, null: false
    t.string "reason"
    t.string "list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mailkick_opt_outs_on_email"
    t.index ["user_type", "user_id"], name: "index_mailkick_opt_outs_on_user_type_and_user_id"
  end

  create_table "networks", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64
    t.string "name"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "network_ipv4"
    t.string "network_ipv6"
    t.boolean "allow_neighbors"
    t.uuid "uuid"
    t.index ["code"], name: "index_networks_on_code", unique: true
    t.index ["name"], name: "index_networks_on_name", unique: true
  end

  create_table "nodes", id: :serial, force: :cascade do |t|
    t.integer "zone_id"
    t.string "code", limit: 64
    t.string "name"
    t.integer "status_id"
    t.text "body"
    t.text "address"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "hours"
    t.text "notes"
    t.integer "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "group_id"
    t.string "website"
    t.string "rss"
    t.string "twitter"
    t.string "wiki"
    t.date "live_date"
    t.uuid "uuid"
    t.index ["code"], name: "index_nodes_on_code", unique: true
    t.index ["contact_id"], name: "index_nodes_on_contact_id"
    t.index ["group_id"], name: "index_nodes_on_group_id"
    t.index ["name"], name: "index_nodes_on_name", unique: true
    t.index ["status_id"], name: "index_nodes_on_status_id"
    t.index ["zone_id"], name: "index_nodes_on_zone_id"
  end

  create_table "notable_jobs", force: :cascade do |t|
    t.string "note_type"
    t.text "note"
    t.text "job"
    t.string "job_id"
    t.string "queue"
    t.decimal "runtime"
    t.decimal "queued_time"
    t.datetime "created_at"
  end

  create_table "notable_requests", force: :cascade do |t|
    t.string "note_type"
    t.text "note"
    t.integer "user_id"
    t.string "user_type"
    t.text "action"
    t.integer "status"
    t.text "url"
    t.string "request_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.text "params"
    t.decimal "request_time"
    t.datetime "created_at"
    t.index ["user_id", "user_type"], name: "index_notable_requests_on_user_id_and_user_type"
  end

  create_table "statuses", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default_display"
    t.integer "ordinal"
    t.uuid "uuid"
    t.index ["code"], name: "index_statuses_on_code", unique: true
    t.index ["name"], name: "index_statuses_on_name", unique: true
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", limit: 64
    t.string "name"
    t.integer "role"
    t.text "body"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "spam"
    t.uuid "uuid"
    t.string "hostmask"
    t.datetime "hostmask_confirmed_at"
    t.string "unconfirmed_hostmask"
    t.index ["code"], name: "index_users_on_code"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "zones", id: :serial, force: :cascade do |t|
    t.string "code", limit: 64
    t.string "name"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.boolean "default"
    t.text "address"
    t.decimal "latitude"
    t.decimal "longitude"
    t.integer "zoom_default"
    t.integer "zoom_min"
    t.integer "zoom_max"
    t.bigint "last_import"
    t.string "chrome_themecolor"
    t.string "chrome_bgcolor"
    t.string "chrome_display"
    t.string "maskicon_color"
    t.string "mstile_color"
    t.bigint "last_event_import"
    t.uuid "uuid"
    t.index ["code"], name: "index_zones_on_code", unique: true
    t.index ["name"], name: "index_zones_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
