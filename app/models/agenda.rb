class Agenda < ActiveRecord::Base
  belongs_to :event
  has_many :sessions, :dependent => :destroy

  validates_presence_of :event_id
end
