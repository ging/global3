class Event < ActiveRecord::Base
  has_one :agenda, :dependent => :destroy
  has_many :sessions, :through => :agenda
  
  acts_as_conference_manager_event
end
