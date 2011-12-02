# Until SocialStream database schema is stable, we will work on its migration
require 'social_stream/migrations/documents'
require 'social_stream/migrations/events'
require 'social_stream/migrations/presence'
require 'social_stream/migrations/linkser'

ActiveRecord::Schema.define(:version => 0) do
  %w(Base Documents Events Presence Linkser).each do |m|
    "SocialStream::Migrations::#{ m }".constantize.new.up
  end
end