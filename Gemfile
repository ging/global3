source 'http://rubygems.org'

# Sprockets .11 breaks Rails
# http://groups.google.com/group/rubyonrails-core/browse_thread/thread/59d8c7813b4d1bbe/508e73f5c8cb47d7
gem 'sprockets', '= 2.0.0.beta.10'
if RUBY_VERSION < '1.9'
  gem 'linecache', '0.43'
end

# Uncomment the following lines if you are planing to
# use a local code of any of these gems
#
# Gems before social_stream-base
# gem 'mailboxer', :path => '../mailboxer'

# gem 'avatars_for_rails', :path => '../avatars_for_rails'
# gem 'conference_manager-ruby', :path => '../conference_manager-ruby'
gem 'conference_manager-ruby'

# Include development dependencies from social_stream-base
gemspec :path => File.join('..', 'social_stream-base')

# social_stream-base
gem 'social_stream-base', :path => '../social_stream-base'

# Gems before social_stream
gem 'social_stream-documents', :path => '../social_stream-documents'
# gem 'social2social', :path => '../social2social'

# social_stream
# gem 'social_stream', :path => '../social_stream'

#gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'mysql'

