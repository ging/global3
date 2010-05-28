class User < ActiveRecord::Base
  belongs_to :actor,
             :validate => true,
             :autosave => true

  delegate :email, :email=, :to => :actor!
  validates_presence_of :email
  validates_format_of :email, :with => Devise.email_regexp, :allow_blank => true
  # TODO: uniqueness of email

  with_options :if => :password_required? do |v|
    v.validates_presence_of :password
    v.validates_confirmation_of :password
    v.validates_length_of :password, :within => Devise.password_length, :allow_blank => true
  end

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

  attr_accessor :_full_name
  attr_accessible :_full_name


  def needs_password?
    # FIXME: with openid support
    true
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
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
