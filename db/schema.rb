# Until SocialStream database schema is stable, we will work on its migration
require File.join(Rails.root, '..', 'social_stream/lib/generators/social_stream/templates/migration')

ActiveRecord::Schema.define(:version => 0) do
  CreateSocialStream.up
end
