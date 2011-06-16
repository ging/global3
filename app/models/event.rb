class Event < ActiveRecord::Base
  has_one :agenda, :dependent => :destroy
  has_many :sessions, :through => :agenda
end
