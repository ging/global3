class Space < ActiveRecord::Base
  validates_presence_of :name

  scope :alphabetic, includes(:actor).order('actors.name')

  def logo
    "spaces/#{ id % 5 + 1 }.png"
  end

  def followers
    User.joins(:actor => :sent_ties) &
      Tie.received_by(self).
      where(:relation_id => Relation.mode("User", "Space").find_by_name("follower"))
  end
end
