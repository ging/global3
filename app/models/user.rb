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

  after_create :initialize_contacts

  # The spaces this user has contact with
  def spaces
    actor.contacts.map(&:actor_to).map(&:space).compact
  end

  def wall
    Activity.wall Contact.tie_ids_query(self)
  end

  def videos
    []
  end
    
  protected
  

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  private

  def initialize_contacts
    # FIXME: automatically load roles
    Role::UserUser.each do |r|
      Contact.create! :actor_from => self.actor,
                      :actor_to => self.actor,
                      :role => Role.find_by_name(r)
    end
  end

  class << self
    def find_by_email(email)
      find(:first, :conditions => { 'actors.email' => email }, :include => :actor)
    end

    def find_by_permalink(p)
      find(:first, :conditions => { 'actors.permalink' => p }, :include => :actor)
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
