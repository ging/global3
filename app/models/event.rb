class Event < ActiveRecord::Base
  include SocialStream::Models::Object

  has_one :agenda, :dependent => :destroy
  has_many :sessions, :through => :agenda
  
  acts_as_conference_manager_event
  
  attr_accessor :step_two
  
  after_create :create_agenda
  
  def create_agenda
      agenda = Agenda.new
      agenda._contact_id = self._contact_id
      self.agenda = agenda
  end
  
end
