# Until SocialStream database schema is stable, we will work on its migration
gems = %w( documents events presence linkser ostatus )

gems.each do |g|
  require "social_stream/migrations/#{ g }"
end

gems.unshift 'base'

ActiveRecord::Schema.define(:version => 0) do
  gems.map(&:camelcase).each do |m|
    "SocialStream::Migrations::#{ m }".constantize.new.up
  end
end
