# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

SocialStream.seed!

# Create admin user if not present
if User.find_by_name('demo').blank?
  u = User.create! :full_name => 'demo',
                   :email => 'demo@dit.upm.es',
                   :password => 'demo',
                   :password_confirmation => 'demo'
  u.confirm!
end
