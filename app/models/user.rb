SocialStream.require_model 'user'

class User
  include SocialStream::Models::Actor

  has_one :profile

  alias_attribute :full_name, :name
  attr_accessible :full_name

  delegate :disabled, :disabled=,
           :to => :actor!

  scope :with_lectures, where('users.lectures is not null')
  scope :with_keynotes, where('users.keynotes is not null')
  scope :alphabetic, includes(:actor).order('actors.name')

  def needs_password?
    # FIXME: with openid support
    true
  end

  def friends
    receiver_subjects(:user, :relations => 'friend')
  end

  def recent_spaces
    receiver_subjects(:space, :relations => 'follower') & Tie.recent
  end

  def videos
    []
  end
  
  def logo
    "followers/#{ id % 3 + 1 }.png"
  end
end
