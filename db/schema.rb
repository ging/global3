# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111005112707) do

  create_table "activities", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "activity_verb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "activities", ["activity_verb_id"], :name => "index_activities_on_activity_verb_id"
  add_index "activities", ["contact_id"], :name => "index_activities_on_contact_id"

  create_table "activity_object_activities", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type"
  end

  add_index "activity_object_activities", ["activity_id"], :name => "index_activity_object_activities_on_activity_id"
  add_index "activity_object_activities", ["activity_object_id"], :name => "index_activity_object_activities_on_activity_object_id"

  create_table "activity_objects", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type", :limit => 45
    t.integer  "like_count",                :default => 0
  end

  create_table "activity_verbs", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors", :force => true do |t|
    t.string   "name"
    t.string   "email",              :default => "",   :null => false
    t.string   "slug"
    t.string   "subject_type"
    t.boolean  "notify_by_email",    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_object_id"
    t.integer  "follower_count",     :default => 0
  end

  add_index "actors", ["activity_object_id"], :name => "index_actors_on_activity_object_id"
  add_index "actors", ["email"], :name => "index_actors_on_email"
  add_index "actors", ["slug"], :name => "index_actors_on_slug", :unique => true

  create_table "agendas", :force => true do |t|
    t.integer  "activity_object_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agendas", ["activity_object_id"], :name => "agendas_on_activity_object_id"
  add_index "agendas", ["event_id"], :name => "agendas_on_event_id"

  create_table "audiences", :force => true do |t|
    t.integer "relation_id"
    t.integer "activity_id"
  end

  add_index "audiences", ["activity_id"], :name => "index_audiences_on_activity_id"
  add_index "audiences", ["relation_id"], :name => "index_audiences_on_relation_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "avatars", :force => true do |t|
    t.integer  "actor_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "active",            :default => true
  end

  add_index "avatars", ["actor_id"], :name => "index_avatars_on_actor_id"

  create_table "comments", :force => true do |t|
    t.integer  "activity_object_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["activity_object_id"], :name => "index_comments_on_activity_object_id"

  create_table "contacts", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "inverse_id"
    t.integer  "ties_count",  :default => 0
  end

  add_index "contacts", ["inverse_id"], :name => "index_contacts_on_inverse_id"
  add_index "contacts", ["receiver_id"], :name => "index_contacts_on_receiver_id"
  add_index "contacts", ["sender_id"], :name => "index_contacts_on_sender_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "type"
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.string   "file_file_size"
    t.boolean  "file_processing"
    t.string   "title"
    t.text     "description"
  end

  add_index "documents", ["activity_object_id"], :name => "index_documents_on_activity_object_id"

  create_table "events", :force => true do |t|
    t.integer  "actor_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "founder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["actor_id"], :name => "events_on_actor_id"

  create_table "groups", :force => true do |t|
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["actor_id"], :name => "index_groups_on_actor_id"

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "permissions", :force => true do |t|
    t.string   "action"
    t.string   "object"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  add_index "posts", ["activity_object_id"], :name => "index_posts_on_activity_object_id"

  create_table "profiles", :force => true do |t|
    t.integer  "actor_id"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization", :limit => 45
    t.string   "phone",        :limit => 45
    t.string   "mobile",       :limit => 45
    t.string   "fax",          :limit => 45
    t.string   "address"
    t.string   "city"
    t.string   "zipcode",      :limit => 45
    t.string   "province",     :limit => 45
    t.string   "country",      :limit => 45
    t.integer  "prefix_key"
    t.string   "description"
    t.string   "experience"
    t.string   "website"
    t.string   "skype",        :limit => 45
    t.string   "im",           :limit => 45
  end

  add_index "profiles", ["actor_id"], :name => "index_profiles_on_actor_id"

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "read",                          :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "relation_permissions", :force => true do |t|
    t.integer  "relation_id"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relation_permissions", ["permission_id"], :name => "index_relation_permissions_on_permission_id"
  add_index "relation_permissions", ["relation_id"], :name => "index_relation_permissions_on_relation_id"

  create_table "relations", :force => true do |t|
    t.integer  "actor_id"
    t.string   "type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_type"
    t.string   "receiver_type"
    t.string   "ancestry"
  end

  add_index "relations", ["actor_id"], :name => "index_relations_on_actor_id"
  add_index "relations", ["ancestry"], :name => "index_relations_on_ancestry"

  create_table "sessions", :force => true do |t|
    t.integer  "activity_object_id"
    t.integer  "agenda_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["activity_object_id"], :name => "sessions_on_activity_object_id"
  add_index "sessions", ["agenda_id"], :name => "sessions_on_agenda_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "ties", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ties", ["contact_id"], :name => "index_ties_on_contact_id"
  add_index "ties", ["relation_id"], :name => "index_ties_on_relation_id"

  create_table "users", :force => true do |t|
    t.string   "encrypted_password",     :limit => 128, :default => "",     :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "actor_id"
    t.boolean  "connected",                             :default => false
    t.string   "status",                                :default => "chat"
  end

  add_index "users", ["actor_id"], :name => "index_users_on_actor_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "activities", "activity_verbs", :name => "index_activities_on_activity_verb_id"
  add_foreign_key "activities", "contacts", :name => "index_activities_on_contact_id"

  add_foreign_key "activity_object_activities", "activities", :name => "index_activity_object_activities_on_activity_id"
  add_foreign_key "activity_object_activities", "activity_objects", :name => "activity_object_activities_on_activity_object_id"

  add_foreign_key "actors", "activity_objects", :name => "actors_on_activity_object_id"

  add_foreign_key "agendas", "activity_objects", :name => "agendas_on_activity_object_id"
  add_foreign_key "agendas", "events", :name => "agendas_on_event_id"

  add_foreign_key "audiences", "activities", :name => "audiences_on_activity_id"
  add_foreign_key "audiences", "relations", :name => "audiences_on_relation_id"

  add_foreign_key "authentications", "users", :name => "authentications_on_user_id"

  add_foreign_key "avatars", "actors", :name => "avatars_on_actor_id"

  add_foreign_key "comments", "activity_objects", :name => "comments_on_activity_object_id"

  add_foreign_key "contacts", "actors", :name => "contacts_on_receiver_id", :column => "receiver_id"
  add_foreign_key "contacts", "actors", :name => "contacts_on_sender_id", :column => "sender_id"

  add_foreign_key "documents", "activity_objects", :name => "documents_on_activity_object_id"

  add_foreign_key "events", "actors", :name => "events_on_actor_id"

  add_foreign_key "groups", "actors", :name => "groups_on_actor_id"

  add_foreign_key "notifications", "conversations", :name => "notifications_on_conversation_id"

  add_foreign_key "posts", "activity_objects", :name => "posts_on_activity_object_id"

  add_foreign_key "profiles", "actors", :name => "profiles_on_actor_id"

  add_foreign_key "receipts", "notifications", :name => "receipts_on_notification_id"

  add_foreign_key "relation_permissions", "permissions", :name => "relation_permissions_on_permission_id"
  add_foreign_key "relation_permissions", "relations", :name => "relation_permissions_on_relation_id"

  add_foreign_key "relations", "actors", :name => "relations_on_actor_id"

  add_foreign_key "sessions", "activity_objects", :name => "sessions_on_activity_object_id"
  add_foreign_key "sessions", "agendas", :name => "sessions_on_agenda_id"

  add_foreign_key "ties", "contacts", :name => "ties_on_contact_id"
  add_foreign_key "ties", "relations", :name => "ties_on_relation_id"

  add_foreign_key "users", "actors", :name => "users_on_actor_id"

end
