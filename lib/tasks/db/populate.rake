namespace :db do
  desc 'Populate database with fake data to developement'
  task :populate => 'db:populate:create'

  namespace :populate do

    desc "Reload populate data"
    task :reload => [ :destroy, :create ]

    desc "Create populate data"
    task :create => :environment do
      require 'populator'
      require 'faker'

      puts "* Create Users"
      User.populate 20 do |user|
        user.confirmed_at = 2.years.ago..Time.now
        user.encrypted_password = ""
        user.password_salt = ""
      end

      User.all.each do |u|
        u.email = Faker::Internet.email
        u.password = u.password_confirmation = "test"
        u.save

        u.__send__ :initialize_contacts
      end

      available_users = User.all

      puts "* Create Spaces"
      Space.populate 20 do |space|

      end

      Space.all.each do |s|
        s.email = Faker::Internet.email
        s.save
      end

      available_spaces = Space.all

      puts "* Create Contacts"
      User.all.each do |u|
        users = available_users.dup - Array(u)
        user_roles = %w( Friend FriendOfFriend ).map{ |r| Role.find_by_name(r) }

        Contact.populate 5..7 do |c|
          user = users.delete_at((rand * users.size).to_i)
          c.actor_from_id = u.actor.id
          c.actor_to_id = user.actor.id
          c.role_id = user_roles.rand.id
        end

        spaces = available_spaces.dup
        space_roles = Role::UserSpace.map{ |r| Role.find_by_name(r) }

        Contact.populate 5..7 do |c|
          space = spaces.delete_at((rand * spaces.size).to_i)
          c.actor_from_id = u.actor.id
          c.actor_to_id = space.actor.id
          c.role_id = space_roles.rand.id
        end

      end
    end

    desc "Destroy populate data"
    task :destroy => :environment do
      puts "* Destroying Actors"
      Actor.destroy_all
    end

  end
end
