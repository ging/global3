# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

[ UserToUser, UserToSpace, ActivityVerb ].each do |klass|
  klass::Available.each do |value|
    klass.find_or_create_by_name value
  end
end

{ 'Friend' => [
  [ 'create' , 'resources', 'weak_set' ],
  [ 'read',    'resources', 'group_set' ],
  [ 'update' , 'resources', 'weak_set' ],
  [ 'destroy', 'resources', 'weak_set' ] ],
  'FriendOfFriend' => [
  [ 'read',    'resources', 'group_set' ] ],
  'Public' => [
  [ 'read',    'resources', 'group_set' ] ],
}.each_pair do |r, ps|
    ps.each do |p|
      rel = UserToUser[r]
      p = Permission.find_or_create_by_action_and_object_and_parameter(*p)
      rel.permissions << p unless rel.permissions.include?(p)
    end
end

{ 'Admin' => [
  [ 'create' , 'resources', 'weak_set' ],
  [ 'read',    'resources', 'group_set' ],
  [ 'update' , 'resources', 'weak_group_set' ],
  [ 'destroy', 'resources', 'weak_group_set' ] ],
  'User' => [
  [ 'create' , 'resources', 'weak_set' ],
  [ 'read',    'resources', 'group_set' ],
  [ 'update' , 'resources', 'weak_group_set' ],
  [ 'destroy', 'resources', 'weak_group_set' ] ],
  'Follower' => [
  [ 'read',    'resources', 'group_set' ] ],
}.each_pair do |r, ps|
    ps.each do |p|
      rel = UserToSpace[r]
      p = Permission.find_or_create_by_action_and_object_and_parameter(*p)
      rel.permissions << p unless rel.permissions.include?(p)
    end
end
                

# Create admin user if not present
if User.find_by_name('vcc').blank?
  u = User.create! :full_name => 'vcc',
                   :email => 'vcc@dit.upm.es',
                   :password => 'admin',
                   :password_confirmation => 'admin'
  u.confirm!
end
