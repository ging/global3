# Until SocialStream database schema is stable, we will work on its migration
require 'social_stream/migration_finder'

# acts-as-taggable-on
SocialStream::MigrationFinder.new 'acts-as-taggable-on',
                   ["generators", "acts_as_taggable_on", "migration", "templates", "active_record", "migration"]



ActiveRecord::Schema.define(:version => 0) do
  ActsAsTaggableOnMigration.up

  # Mailboxer
  mailboxer_path = Gem::GemPathSearcher.new.find('mailboxer').full_gem_path
  mailboxer_migration = File.join([mailboxer_path,'db', 'migrate'])
  ActiveRecord::Migrator.migrate mailboxer_migration

  # SocialStream::Base
  ActiveRecord::Migrator.migrate File.expand_path("../../../social_stream-base/db/migrate/", __FILE__)

  # SocialStream::Documents
  ActiveRecord::Migrator.migrate File.expand_path("../../../social_stream-documents/db/migrate/", __FILE__)

  create_table :events do |t|
    t.references :activity_object
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
