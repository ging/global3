class Event < ActiveRecord::Base
  include SocialStream::Models::Subject

  has_one :agenda, :dependent => :destroy
  has_many :sessions, :through => :agenda
  
  #acts_as_conference_manager_event





  
end
