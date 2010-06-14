# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.all_available.each do |role|
  Role.find_or_create_by_name role
end

ActivityVerb::Available.each do |verb|
  ActivityVerb.find_or_create_by_name verb
end
