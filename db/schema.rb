# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100820092637) do

  create_table "activities", :force => true do |t|
    t.integer  "activity_verb_id"
    t.integer  "tie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "activities", ["activity_verb_id"], :name => "fk_activity_verb"
  add_index "activities", ["tie_id"], :name => "fk_activities_tie"

  create_table "activity_object_activities", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",               :limit => 45
  end

  add_index "activity_object_activities", ["activity_id"], :name => "fk_activity_object_activities_1"
  add_index "activity_object_activities", ["activity_object_id"], :name => "fk_activity_object_activities_2"

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_object_id"
  end

  add_index "actors", ["activity_object_id"], :name => "fk_actors_activity_object"
  add_index "actors", ["email"], :name => "index_actors_on_email"
  add_index "actors", ["permalink"], :name => "index_actors_on_permalink", :unique => true

  create_table "agenda_entries", :force => true do |t|
    t.integer  "agenda_id"
    t.datetime "updated_at"
    t.string   "created_at", :limit => 45
  end

  add_index "agenda_entries", ["agenda_id"], :name => "fk_sesion_agenda"

  create_table "agendas", :force => true do |t|
    t.integer  "event_id"
    t.datetime "updated_at"
    t.string   "created_at", :limit => 45
  end

  add_index "agendas", ["event_id"], :name => "fk_agenda_event"

  create_table "album_photos", :force => true do |t|
    t.integer  "album_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "album_photos", ["album_id"], :name => "fk_album_photo_album"
  add_index "album_photos", ["photo_id"], :name => "fk_album_photo_photo"

  create_table "albums", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "activity_object_id"
    t.text     "text"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "comments", ["activity_object_id"], :name => "fk_commets_activity_object"

  create_table "documents", :force => true do |t|
    t.string   "name",               :limit => 45
    t.string   "tipo",               :limit => 45
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.string   "updated_at",         :limit => 45
  end

  add_index "documents", ["activity_object_id"], :name => "fk_document_document"

  create_table "events", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.string   "updated_at",         :limit => 45
  end

  add_index "events", ["activity_object_id"], :name => "fk_event_object"

  create_table "logos", :force => true do |t|
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
    t.string   "thumbnail",    :limit => 45
    t.string   "filename",     :limit => 45
    t.integer  "size"
    t.string   "content_type", :limit => 45
    t.string   "type",         :limit => 45
    t.integer  "parent_id"
  end

  add_index "logos", ["actor_id"], :name => "fk_logo_actor"
  add_index "logos", ["id"], :name => "fk_logos_parent"

  create_table "permissions", :force => true do |t|
    t.string   "action"
    t.string   "object"
    t.string   "parameter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "updated_at"
    t.string   "created_at",         :limit => 45
  end

  add_index "photos", ["activity_object_id"], :name => "fk_photo_object"

  create_table "posts", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parent_id",          :limit => 45
    t.text     "text"
  end

  add_index "posts", ["activity_object_id"], :name => "fk_post_object"

  create_table "private_messages", :force => true do |t|
    t.string   "description",        :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_object_id"
  end

  add_index "private_messages", ["activity_object_id"], :name => "fk_object_type_message"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization", :limit => 45
    t.string   "phone",        :limit => 45
    t.string   "mobile",       :limit => 45
    t.string   "fax",          :limit => 45
    t.string   "address",      :limit => 45
    t.string   "city",         :limit => 45
    t.string   "zipcode",      :limit => 45
    t.string   "province",     :limit => 45
    t.string   "country",      :limit => 45
    t.integer  "prefix_key"
    t.string   "description"
    t.string   "url"
    t.string   "skype",        :limit => 45
    t.string   "im",           :limit => 45
  end

  add_index "profiles", ["user_id"], :name => "fk_profile_user"

  create_table "relation_permissions", :force => true do |t|
    t.integer  "relation_id"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "relation_id"
  end

  add_index "relation_permissions", ["relation_id"], :name => "fk_relation_permissions_relation"
  add_index "relation_permissions", ["permission_id"], :name => "fk_relation_permissions_permission"

  create_table "relations", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_type"
    t.string   "receiver_type"
    t.string   "ancestry"
    t.integer  "inverse_id"
    t.integer  "granted_id"
    t.boolean  "default", :default => false
  end

  add_index "relations", ["ancestry"]
  add_index "relations", ["inverse_id"]
  add_index "relations", ["granted_id"]

  create_table "spaces", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "actor_id"
  end

  add_index "spaces", ["actor_id"], :name => "fk_spaces_actors"

  create_table "tags", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_activity_objects", :force => true do |t|
    t.integer "tag_id"
    t.integer "activity_object_id"
  end

  add_index "tags_activity_objects", ["activity_object_id"], :name => "fk_tags_activity_objects_2"
  add_index "tags_activity_objects", ["tag_id"], :name => "fk_tags_activity_objects_1"

  create_table "ties", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
  end

  add_index "ties", ["receiver_id"], :name => "fk_tie_receiver"
  add_index "ties", ["relation_id"], :name => "fk_tie_relation"
  add_index "ties", ["sender_id"], :name => "fk_tie_sender"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",             :limit => 45
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.integer  "actor_id"
    t.string   "userscol",             :limit => 45
		t.integer   "lectures"
		t.integer  "keynotes"
  end

  add_index "users", ["actor_id"], :name => "fk_users_actors"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.string   "updated_at",         :limit => 45
  end

  add_index "videos", ["activity_object_id"], :name => "fk_video_object"

  add_foreign_key "activities", "activity_verbs", :name => "fk_activity_verb"
  add_foreign_key "activities", "ties", :name => "fk_activities_tie"

  add_foreign_key "activity_object_activities", "activities", :name => "fk_activity_object_activities_1"
  add_foreign_key "activity_object_activities", "activity_objects", :name => "fk_activity_object_activities_2"

  add_foreign_key "actors", "activity_objects", :name => "fk_actors_activity_object"

  add_foreign_key "agenda_entries", "agendas", :name => "fk_sesion_agenda"

  add_foreign_key "agendas", "events", :name => "fk_agenda_event"

  add_foreign_key "album_photos", "albums", :name => "fk_album_photo_album"
  add_foreign_key "album_photos", "photos", :name => "fk_album_photo_photo"

  add_foreign_key "comments", "activity_objects", :name => "fk_commets_activity_object"

  add_foreign_key "documents", "activity_objects", :name => "fk_document_document"

  add_foreign_key "events", "activity_objects", :name => "fk_event_object"

  add_foreign_key "logos", "actors", :name => "fk_logo_actor"
  add_foreign_key "logos", "logos", :name => "fk_logos_parent", :column => "id", :primary_key => "actor_id"

  add_foreign_key "photos", "activity_objects", :name => "fk_photo_object"

  add_foreign_key "posts", "activity_objects", :name => "fk_post_object"

  add_foreign_key "private_messages", "activity_objects", :name => "fk_object_type_message"

  add_foreign_key "profiles", "users", :name => "fk_profile_user"

  add_foreign_key "relation_permissions", "relations", :name => "fk_relation_permissions_relation"
  add_foreign_key "relation_permissions", "permissions", :name => "fk_relation_permissions_permission"

  add_foreign_key "spaces", "actors", :name => "fk_spaces_actors"

  add_foreign_key "tags_activity_objects", "activity_objects", :name => "fk_tags_activity_objects_2"
  add_foreign_key "tags_activity_objects", "tags", :name => "fk_tags_activity_objects_1"

  add_foreign_key "ties", "actors", :name => "fk_tie_receiver", :column => "receiver_id"
  add_foreign_key "ties", "actors", :name => "fk_tie_sender", :column => "sender_id"
  add_foreign_key "ties", "relations", :name => "fk_ties_relation"

  add_foreign_key "users", "actors", :name => "fk_users_actors"

  add_foreign_key "videos", "activity_objects", :name => "fk_video_object"

end
