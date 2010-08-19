class Relation < ActiveRecord::Base
  Available = {
    User => {
      User  => %w( Private Friend FriendOfFriend Public ),
      Space => %w( Admin User Follower )
    }
  }

  class << self
    def all_available
      Available.values.map(&:values).flatten.uniq
    end

    def [] name
      find_by_name name
    end
  end
end
