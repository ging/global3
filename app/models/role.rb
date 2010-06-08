class Role < ActiveRecord::Base
  UserUser = %w( Private Friend FriendOfFriend Public )
  UserSpace = %w( Admin User Follower )
end
