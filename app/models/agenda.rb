class Agenda < ActiveRecord::Base
  include SocialStream::Models::Object

  belongs_to :event
  has_many :sessions, :dependent => :destroy

  validates_presence_of :event_id
end
