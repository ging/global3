class ActivityObject < ActiveRecord::Base
  has_many :activity_object_activities
  has_many :activities, :through => :activity_object_activities

  has_one :post, :dependent => :destroy

end
