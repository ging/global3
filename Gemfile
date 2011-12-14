source 'http://rubygems.org'

if RUBY_VERSION < '1.9'
  gem 'linecache', '0.43'
end

# Uncomment the following lines if you are planing to
# use a local code of any of these gems
#
# Gems before social_stream-base:
#
# gem 'mailboxer', :path => '../mailboxer'
# gem 'linkser', :path => '../linkser'
# gem 'social_cheesecake', :path => '../SocialCheesecake/rails'
# gem 'avatars_for_rails', :path => '../avatars_for_rails'#here

# Include development dependencies from social_stream-base
gemspec :path => File.join('..', 'social_stream', 'base')

# Gems before social_stream
# gem 'social_stream-base', :path => '../social_stream/base'

# gem 'social_stream-documents', :path => '../social_stream/documents'

# Gems before social_stream-events:
#
# gem 'conference_manager-ruby', :path => '../conference_manager-ruby'
# gem 'social_stream-events', :path => '../social_stream/events'

# gem 'social2social', :path => '../social2social'

# social_stream
gem 'social_stream', :path => '../social_stream'

gem 'social_stream-presence', :path => '../social_stream/presence'

#gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'mysql2'

if RUBY_VERSION > '1.9'
  group :development do
    gem 'ruby-debug19', :require => 'ruby-debug'
  end
end


