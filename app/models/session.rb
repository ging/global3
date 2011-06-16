class Session < ActiveRecord::Base
  belongs_to :agenda
  has_one :event, :through => :agenda

  validates_presence_of :agenda_id
end
