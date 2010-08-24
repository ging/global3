Factory.define :tie do |t|
  t.sender { |s| Factory(:user).actor }
  t.receiver { |r| Factory(:user).actor }
  t.relation { |r| UserToUser.strongest }
end

Factory.define :friend_tie, :parent => :tie do |t|
  t.relation { |r| UserToUser['Friend'] }
end

Factory.define :fof_tie, :parent => :tie do |t|
  t.relation { |r| UserToUser['FriendOfFriend'] }
end

Factory.define :public_tie, :parent => :tie do |t|
  t.relation { |r| UserToUser['Public'] }
end
