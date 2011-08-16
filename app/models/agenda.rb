class Agenda < ActiveRecord::Base
  include SocialStream::Models::Object

  belongs_to :event
  has_many :sessions, :dependent => :destroy

  validates_presence_of :event_id

=begin
  def to_fullcalendar_json
    sessions.map(&:to_fullcalendar_json).join(", ")

    "[#{sessions.map(&:to_fullcalendar_json).join(", ")}]"
  end

  def create_session
    session = Session.new
    session._contact_id= self._contact_id
    #self.sessions = session
    return session
  end

=end

  def event
    #AgendaEvent = Event.find(1)

  end



end




