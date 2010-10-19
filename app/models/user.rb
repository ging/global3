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

  # == Recomendations
  
  # The users this user has tie with
  def users
    receiver_subjects(:user)
  end

  # FIXME with recommendations engine
  def suggested_user
    suggestion(:user)
  end

  # The spaces this user has tie with
  def spaces
    receiver_subjects(:space, :relations => 'follower')
  end

  # FIXME with recommendations engine
  def suggested_space
    suggestion(:space)
  end

  def videos
    []
  end
  
  def logo
    "followers/#{ id % 3 + 1 }.png"
  end
end
