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

ActiveRecord::Schema.define(:version => 0) do

  create_table "activities", :force => true do |t|
    t.integer  "activity_verb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "activities", ["activity_verb_id"], :name => "index_activities_on_activity_verb_id"

  create_table "activity_object_activities", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",               :limit => 45
  end

  add_index "activity_object_activities", ["activity_id"], :name => "index_activity_object_activities_on_activity_id"
  add_index "activity_object_activities", ["activity_object_id"], :name => "index_activity_object_activities_on_activity_object_id"

  create_table "activity_objects", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type", :limit => 45
  end

  create_table "activity_verbs", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors", :force => true do |t|
    t.string   "name",               :limit => 45
    t.string   "email",                            :default => "", :null => false
    t.string   "permalink",          :limit => 45
    t.string   "subject_type",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_object_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "actors", ["activity_object_id"], :name => "index_actors_on_activity_object_id"
  add_index "actors", ["email"], :name => "index_actors_on_email"
  add_index "actors", ["permalink"], :name => "index_actors_on_permalink", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "activity_object_id"
    t.text     "text"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "comments", ["activity_object_id"], :name => "index_comments_on_activity_object_id"

  create_table "groups", :force => true do |t|
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "groups", ["actor_id"], :name => "index_groups_on_actor_id"

  create_table "messages", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  add_index "messages", ["activity_object_id"], :name => "index_messages_on_activity_object_id"

  create_table "permissions", :force => true do |t|
    t.string   "action"
    t.string   "object"
    t.string   "function"
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

  create_table "relation_permissions", :force => true do |t|
    t.integer  "relation_id"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relation_permissions", ["permission_id"], :name => "index_relation_permissions_on_permission_id"
  add_index "relation_permissions", ["relation_id"], :name => "index_relation_permissions_on_relation_id"

  create_table "relations", :force => true do |t|
    t.string   "name",          :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_type"
    t.string   "receiver_type"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  add_index "relations", ["parent_id"], :name => "index_relations_on_parent_id"

  create_table "tags", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_activity_objects", :force => true do |t|
    t.integer "tag_id"
    t.integer "activity_object_id"
  end

  add_index "tags_activity_objects", ["activity_object_id"], :name => "index_tags_activity_objects_on_activity_object_id"
  add_index "tags_activity_objects", ["tag_id"], :name => "index_tags_activity_objects_on_tag_id"

  create_table "tie_activities", :force => true do |t|
    t.integer "tie_id"
    t.integer "activity_id"
    t.boolean "read"
    t.boolean "original",    :default => true
  end

  add_index "tie_activities", ["activity_id"], :name => "index_tie_activities_on_activity_id"
  add_index "tie_activities", ["tie_id"], :name => "index_tie_activities_on_tie_id"

  create_table "ties", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ties", ["receiver_id"], :name => "index_ties_on_receiver_id"
  add_index "ties", ["relation_id"], :name => "index_ties_on_relation_id"
  add_index "ties", ["sender_id"], :name => "index_ties_on_sender_id"

  create_table "users", :force => true do |t|
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "actor_id"
  end

  add_index "users", ["actor_id"], :name => "index_users_on_actor_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "activities", "activity_verbs", :name => "index_activities_on_activity_verb_id"

  add_foreign_key "activity_object_activities", "activities", :name => "index_activity_object_activities_on_activity_id"
  add_foreign_key "activity_object_activities", "activity_objects", :name => "activity_object_activities_on_activity_object_id"

  add_foreign_key "actors", "activity_objects", :name => "actors_on_activity_object_id"

  add_foreign_key "authentications", "users", :name => "authentications_on_user_id"

  add_foreign_key "comments", "activity_objects", :name => "comments_on_activity_object_id"

  add_foreign_key "groups", "actors", :name => "groups_on_actor_id"

  add_foreign_key "messages", "activity_objects", :name => "messages_on_activity_object_id"

  add_foreign_key "posts", "activity_objects", :name => "posts_on_activity_object_id"

  add_foreign_key "profiles", "actors", :name => "profiles_on_actor_id"

  add_foreign_key "relation_permissions", "permissions", :name => "relation_permissions_on_permission_id"
  add_foreign_key "relation_permissions", "relations", :name => "relation_permissions_on_relation_id"

  add_foreign_key "tags_activity_objects", "activity_objects", :name => "tags_activity_objects_on_activity_object_id"
  add_foreign_key "tags_activity_objects", "tags", :name => "tags_activity_objects_on_tag_id"

  add_foreign_key "tie_activities", "activities", :name => "tie_activities_on_activity_id"
  add_foreign_key "tie_activities", "ties", :name => "tie_activities_on_tie_id"

  add_foreign_key "ties", "actors", :name => "ties_on_receiver_id", :column => "receiver_id"
  add_foreign_key "ties", "actors", :name => "ties_on_relation_id", :column => "sender_id"
  add_foreign_key "ties", "relations", :name => "ties_on_sender_id"

  add_foreign_key "users", "actors", :name => "users_on_actor_id"

end
