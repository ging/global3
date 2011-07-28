# Until SocialStream database schema is stable, we will work on its migration
require 'social_stream/migrations/documents'

ActiveRecord::Schema.define(:version => 0) do
  SocialStream::Migrations::Documents.new.up

  create_table :events do |t|
    t.references :actor
    t.datetime :start_at
    t.datetime :end_at
    t.string   :name
    t.text     :description

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
    t.string   :name
    
    t.timestamps
  end
end
