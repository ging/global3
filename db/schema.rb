# Until SocialStream database schema is stable, we will work on its migration
require 'social_stream/migrations/documents'
require 'social_stream/migrations/events'

ActiveRecord::Schema.define(:version => 0) do
  %w(Base Documents Events).each do |m|
    "SocialStream::Migrations::#{ m }".constantize.new.up
  end
end
