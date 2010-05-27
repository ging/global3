class User < ActiveRecord::Base
  belongs_to :actor,
             :validate => true,
             :autosave => true

  delegate :email, :email=, :to => :actor!

  scope :by_email, lambda { |email|
    joins(:actor).where('actors.email' => email)
  }

  scope :by_permalink, lambda { |p|
    joins(:actor).where('actors.permalink' => p)
  }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable,
  # :trackable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  def actor!
    actor || build_actor
  end

  class << self
    # Overwrite devise default find method to support login with email,
    # presence ID and login
    def find_for_authentication(conditions)
      if ( login = conditions[:email] ).present?
        if login =~ /@/
          # TODO presence_domain
          if login =~ /(.*)@\{ Site.current.presence_domain \}$/
            by_permalink($1)
          else
            by_email(login)
          end
        else
          by_permalink(login)
        end.first
      else
        super
      end
    end
  end
end
