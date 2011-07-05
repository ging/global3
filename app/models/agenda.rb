class Agenda < ActiveRecord::Base
  include SocialStream::Models::Object

  belongs_to :event
  has_many :sessions, :dependent => :destroy

  validates_presence_of :event_id
  
  def to_fullcalendar_json
    body = ""
    
    self.sessions.each do |session|
      body = body + "," + session.to_fullcalendar_json
    end
    
    #body = self.sessions.map{|session| session.to_fullcalendar_json}.join(",")
    "[#{body}]"
  end
    
  
end

