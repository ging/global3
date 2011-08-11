# Until SocialStream database schema is stable, we will work on its migration
require 'social_stream/migrations/documents'

ActiveRecord::Schema.define(:version => 0) do
  SocialStream::Migrations::Documents.new.up

  create_table :events do |t|
    t.references :actor
    t.datetime :start_at
    t.datetime :end_at
    t.integer :founder_id
    t.timestamps
  end

  create_table :agendas do |t|
    t.references :activity_object
    t.references :event
    t.timestamps
  end

  create_table :sessions do |t|
    t.references :activity_object
    t.references :agenda
    t.datetime :start_at
    t.datetime :end_at
    t.string   :title
    t.string  :description
    t.timestamps
  end

  create_table :calendar_event_series do |t|
    t.integer  :frequency,    :default => 1
    t.string   :period,       :default => "monthly"
    t.datetime :starttime
    t.datetime :endtime
    t.boolean  :all_day,      :default => false
    t.datetime :created_at
    t.datetime :updated_at
    t.datetime :repeat_until
    t.string   :title
    t.text     :description
    t.integer  :object_id
    t.string   :object_type
  end

  create_table :calendar_events do |t|
    t.string   :title
    t.string   :url
    t.text     :description
    t.datetime :starttime
    t.datetime :endtime
    t.boolean  :all_day,       :default => false
    t.integer  :calendar_event_series_id
    t.string   :object_type
    t.integer  :object_id
    t.string   :type
    t.datetime :created_at
    t.datetime :updated_at
  end

  add_foreign_key "events", "actors", :name => "events_on_actor_id"

  add_foreign_key "agendas", "activity_objects", :name => "agendas_on_activity_object_id"
  add_foreign_key "agendas", "events", :name => "agendas_on_event_id"

  add_foreign_key "sessions", "activity_objects", :name => "sessions_on_activity_object_id"
  add_foreign_key "sessions", "agendas", :name => "sessions_on_agenda_id"
end
