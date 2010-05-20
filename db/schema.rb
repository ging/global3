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

ActiveRecord::Schema.define(:version => 0) do

  create_table "actions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.integer  "verb_id"
    t.string   "description", :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["verb_id"], :name => "fk_actividad_verb"

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
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors", :force => true do |t|
    t.string   "name",               :limit => 45
    t.integer  "activity_object_id"
    t.string   "email",              :limit => 45
    t.string   "permalink",          :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actors", ["activity_object_id"], :name => "fk_actor_object"

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

  create_table "contact_activities", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_activities", ["activity_id"], :name => "fk_actividad_actor_actividad"
  add_index "contact_activities", ["contact_id"], :name => "fk_actividad_actor_contacto"

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
  end

  add_index "logos", ["actor_id"], :name => "fk_logo_actor"

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
  end

  add_index "profiles", ["user_id"], :name => "fk_profile_user"

  create_table "role_action", :force => true do |t|
    t.integer  "action_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_action", ["action_id"], :name => "fk_role_action_action"
  add_index "role_action", ["role_id"], :name => "fk_role_action_role"

  create_table "spaces", :force => true do |t|
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spaces", ["actor_id"], :name => "fk_espacio_actor"

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

  create_table "users", :force => true do |t|
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",   :limit => 45
    t.string   "password",   :limit => 45
  end

  add_index "users", ["actor_id"], :name => "fk_user_actor"

  create_table "verbs", :force => true do |t|
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.integer  "activity_object_id"
    t.datetime "created_at"
    t.string   "updated_at",         :limit => 45
  end

  add_index "videos", ["activity_object_id"], :name => "fk_video_object"

end
