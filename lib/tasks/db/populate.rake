namespace :db do
  desc 'Populate database with fake data for development'
  task :populate => [ 'db:seed', 'db:populate:create' ]

  namespace :populate do

    desc "Reload populate data"
    task :reload => [ 'db:reset', :create ]

    desc "Create populate data"
    task :create => :environment do

      puts "* Create Users"
      20.times do
        u = User.create :full_name => Forgery::Name.full_name,
                        :email => Forgery::Internet.email_address,
                        :password => 'test',
                        :password_confirmation => 'test'
        u.confirm!
      end

      available_users = User.all

      puts "* Create Spaces"
      20.times do
        Space.create :name  => Forgery::Name.company_name,
                     :email => Forgery::Internet.email_address
      end

      available_spaces = Space.all

      puts "* Create Ties"
      User.all.each do |u|
        users = available_users.dup - Array(u)
        user_relations = %w( Friend FriendOfFriend ).map{ |r| Relation.mode('User', 'User').find_by_name(r) }

        Forgery::Basic.number.times do
          user = users.delete_at((rand * users.size).to_i)
          u.ties.create :receiver => user.actor,
                        :relation => user_relations.random
        end
        spaces = available_spaces.dup
        space_relations = Relation.mode('User', 'Space')

        Forgery::Basic.number.times do
          space = spaces.delete_at((rand * spaces.size).to_i)
          u.ties.create :receiver => space.actor,
                        :relation => space_relations.random
        end
      end
    end
  end
end
