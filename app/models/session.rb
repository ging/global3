class Session < ActiveRecord::Base
  include SocialStream::Models::Object

  belongs_to :agenda
  has_one :event, :through => :agenda

  validates_presence_of :agenda_id
  
  acts_as_conference_manager_session
end
