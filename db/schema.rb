# Until SocialStream database schema is stable, we will work on its migration
require 'social_stream/migrations/documents'
require 'social_stream/migrations/events'

ActiveRecord::Schema.define(:version => 0) do
  SocialStream::Migrations::Documents.new.up
  SocialStream::Migrations::Events.new.up  
 
end
