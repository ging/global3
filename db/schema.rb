# Until SocialStream database schema is stable, we will work on its migration
require File.join(Rails.root, '../', 'social_stream', 'spec', 'support', 'migrations')

ActiveRecord::Schema.define(:version => 0) do
  CreateMailboxer.up
  CreateSocialStream.up
  ActsAsTaggableOnMigration.up
  CreateSocialStreamDocuments.up

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

    t.timestamps
  end
end
