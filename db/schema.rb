# Until SocialStream database schema is stable, we will work on its migration
require File.join(Rails.root, '..', 'social_stream/lib/generators/social_stream/templates/migration')

# Load Mailboxer schema
finder = Gem::GemPathSearcher.new
mailboxer_spec = finder.find('mailboxer')
mailboxer_migration =
  finder.matching_files(mailboxer_spec,
                       'generators/mailboxer/templates/migration.rb').first
require mailboxer_migration

ActiveRecord::Schema.define(:version => 0) do
  CreateMailboxer.up
  CreateSocialStream.up
end
