class Session < ActiveRecord::Base
  belongs_to :agenda
  has_one :event, :through => :agenda

  validates_presence_of :agenda_id
  
  acts_as_conference_manager_session
end
