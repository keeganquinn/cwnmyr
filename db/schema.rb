# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150311000001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string  "code",   limit: 64
    t.string  "name"
    t.boolean "hidden"
    t.string  "email"
    t.string  "phone"
    t.string  "notes"
    t.index ["code"], name: "index_contacts_on_code", unique: true, using: :btree
    t.index ["hidden"], name: "index_contacts_on_hidden", using: :btree
    t.index ["name"], name: "index_contacts_on_name", unique: true, using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "code",       limit: 64
    t.string   "name"
    t.text     "body"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_groups_on_code", unique: true, using: :btree
    t.index ["name"], name: "index_groups_on_name", unique: true, using: :btree
  end

  create_table "groups_users", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_users_on_group_id", using: :btree
    t.index ["user_id"], name: "index_groups_users_on_user_id", using: :btree
  end

  create_table "host_properties", force: :cascade do |t|
    t.integer  "host_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_host_properties_on_host_id", using: :btree
    t.index ["key"], name: "index_host_properties_on_key", using: :btree
  end

  create_table "host_types", force: :cascade do |t|
    t.string   "code",       limit: 64
    t.string   "name"
    t.text     "body"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_host_types_on_code", unique: true, using: :btree
    t.index ["name"], name: "index_host_types_on_name", unique: true, using: :btree
  end

  create_table "hosts", force: :cascade do |t|
    t.integer  "node_id"
    t.string   "name"
    t.integer  "host_type_id"
    t.integer  "status_id"
    t.text     "body"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["host_type_id"], name: "index_hosts_on_host_type_id", using: :btree
    t.index ["name"], name: "index_hosts_on_name", using: :btree
    t.index ["node_id"], name: "index_hosts_on_node_id", using: :btree
    t.index ["status_id"], name: "index_hosts_on_status_id", using: :btree
  end

  create_table "interface_properties", force: :cascade do |t|
    t.integer  "interface_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["interface_id"], name: "index_interface_properties_on_interface_id", using: :btree
    t.index ["key"], name: "index_interface_properties_on_key", using: :btree
  end

  create_table "interface_types", force: :cascade do |t|
    t.string   "code",       limit: 64
    t.string   "name"
    t.text     "body"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_interface_types_on_code", unique: true, using: :btree
    t.index ["name"], name: "index_interface_types_on_name", unique: true, using: :btree
  end

  create_table "interfaces", force: :cascade do |t|
    t.integer  "host_id"
    t.string   "code"
    t.string   "name"
    t.integer  "interface_type_id"
    t.integer  "status_id"
    t.text     "body"
    t.string   "address_ipv4"
    t.string   "address_ipv6"
    t.string   "address_mac"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "altitude"
    t.string   "essid"
    t.string   "security_psk"
    t.string   "channel"
    t.decimal  "tx_power"
    t.decimal  "rx_sensitivity"
    t.decimal  "cable_loss"
    t.decimal  "antenna_gain"
    t.decimal  "beamwidth_h"
    t.decimal  "beamwidth_v"
    t.decimal  "azimuth"
    t.decimal  "elevation"
    t.string   "polarity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["code"], name: "index_interfaces_on_code", using: :btree
    t.index ["host_id"], name: "index_interfaces_on_host_id", using: :btree
    t.index ["interface_type_id"], name: "index_interfaces_on_interface_type_id", using: :btree
    t.index ["name"], name: "index_interfaces_on_name", using: :btree
    t.index ["status_id"], name: "index_interfaces_on_status_id", using: :btree
  end

  create_table "node_links", force: :cascade do |t|
    t.integer  "node_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_node_links_on_name", using: :btree
    t.index ["node_id"], name: "index_node_links_on_node_id", using: :btree
  end

  create_table "nodes", force: :cascade do |t|
    t.integer  "zone_id"
    t.string   "code",       limit: 64
    t.string   "name"
    t.integer  "status_id"
    t.text     "body"
    t.text     "address"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "hours"
    t.text     "notes"
    t.integer  "contact_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_nodes_on_code", unique: true, using: :btree
    t.index ["contact_id"], name: "index_nodes_on_contact_id", using: :btree
    t.index ["name"], name: "index_nodes_on_name", unique: true, using: :btree
    t.index ["status_id"], name: "index_nodes_on_status_id", using: :btree
    t.index ["zone_id"], name: "index_nodes_on_zone_id", using: :btree
  end

  create_table "nodes_tags", force: :cascade do |t|
    t.integer  "node_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_nodes_tags_on_node_id", using: :btree
    t.index ["tag_id"], name: "index_nodes_tags_on_tag_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "code",       limit: 64
    t.string   "name"
    t.string   "color"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_statuses_on_code", unique: true, using: :btree
    t.index ["name"], name: "index_statuses_on_name", unique: true, using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "code",       limit: 64
    t.string   "name"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_tags_on_code", unique: true, using: :btree
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "user_links", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_links_on_name", using: :btree
    t.index ["user_id"], name: "index_user_links_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "code",                   limit: 64
    t.string   "name"
    t.integer  "role"
    t.text     "body"
    t.index ["code"], name: "index_users_on_code", unique: true, using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "zones", force: :cascade do |t|
    t.string   "code",       limit: 64
    t.string   "name"
    t.text     "body"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_zones_on_code", unique: true, using: :btree
    t.index ["name"], name: "index_zones_on_name", unique: true, using: :btree
  end

end
