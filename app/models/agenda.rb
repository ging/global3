class Agenda < ActiveRecord::Base
  belongs_to :event
  has_many :sessions, :dependent => :destroy
end
