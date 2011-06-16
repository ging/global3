class Session < ActiveRecord::Base
  belongs_to :agenda
  has_one :event, :through => :agenda
end
