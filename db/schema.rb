# Until SocialStream database schema is stable, we will work on its migration
require File.join(Rails.root, '..', 'social_stream', 'spec', 'support', 'migrations')

ActiveRecord::Schema.define(:version => 0) do
  CreateMailboxer.up
  CreateSocialStream.up
  ActsAsTaggableOnMigration.up
end
