SocialStream.require_model 'user'

class User
  include SocialStream::Models::Subject

  alias_attribute :full_name, :name
  attr_accessible :full_name

  delegate :disabled, :disabled=,
           :to => :actor!

  scope :alphabetic, includes(:actor).order('actors.name')

  def needs_password?
    # FIXME: with openid support
    true
  end
end
