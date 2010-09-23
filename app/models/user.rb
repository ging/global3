class User < ActiveRecord::Base
  include SocialStream::Models::Actor

  has_one :profile

  alias :full_name :name
  alias :full_name= :name=

	scope :with_lectures, where('users.lectures is not null')
	scope :with_keynotes, where('users.keynotes is not null')
	scope :alphabetic, includes(:actor).order('actors.name')

  validates_presence_of :full_name, :email
  validates_format_of :email, :with => Devise.email_regexp, :allow_blank => true
  # TODO: uniqueness of email

  with_options :if => :password_required? do |v|
    v.validates_presence_of :password
    v.validates_confirmation_of :password
    v.validates_length_of :password, :within => Devise.password_length, :allow_blank => true
  end

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable,
  # :trackable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :full_name, :email, :password, :password_confirmation

  def needs_password?
    # FIXME: with openid support
    true
  end

  after_create :initialize_ties

  def friends
    User.joins(:actor => :sent_ties) &
      Tie.received_by(self).
      where(:relation_id => Relation.mode("User", "User").find_by_name("friend"))
  end

  # == Recomendations
  
  # The users this user has tie with
  def users
    actor.sent_ties.includes(:receiver).map(&:receiver).map(&:user).compact
  end

  # FIXME with recommendations engine
  def suggested_user
    s = (User.all - users)
    s[rand(s.size)]
  end

  # The spaces this user has tie with
  def spaces
    actor.sent_ties.map(&:receiver).map(&:space).compact
  end

  # FIXME with recommendations engine
  def suggested_space
    s = (Space.all - spaces)
    s[rand(s.size)]
  end

  def videos
    []
  end
  
  def logo
    "followers/#{ id % 3 + 1 }.png"
  end
    
  protected
  

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  private

  def initialize_ties
    Tie.create! :sender   => self.actor,
                :receiver => self.actor,
                :relation => Relation.mode('User', 'User').find_by_name('friend')
  end

  class << self
    %w( email permalink name ).each do |a|
      eval <<-EOS
    def find_by_#{ a }(#{ a })             # def find_by_email(email)
      find :first,                         #   find(:first,
           :include => :actor,             #         :include => :actor,
           :conditions =>                  #         :conditions =>
             { 'actors.#{ a }' => #{ a } } #           { 'actors.email' => email }
    end                                    # end
      EOS
    end

    # Overwrite devise default find method to support login with email,
    # presence ID and login
    def find_for_authentication(conditions)
      if ( login = conditions[:email] ).present?
        if login =~ /@/
          # TODO presence_domain
          if login =~ /(.*)@\{ Site.current.presence_domain \}$/
            find_by_permalink($1)
          else
            find_by_email(login)
          end
        else
          find_by_permalink(login)
        end
      else
        super
      end
    end

    def find_or_initialize_with_error_by(attribute, value, error=:invalid)
      if attribute == :email
        find_or_initialize_with_error_by_email(value, error)
      else
        super
      end
    end

    # Overwrite devise default method to support finding with actor.email
    def find_or_initialize_with_error_by_email(value, error)
      if value.present?
        record = find_by_email(value)
      end

      unless record
        record = new

        if value.present?
          record.email = value
        else
          error = :blank
        end

        record.errors.add(:email, error)
      end

      record
		end





  end
end
