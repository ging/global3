class Video < ActiveRecord::Base
  belongs_to :activity_object

  before_create :create_activity_object

  has_many :activity_object_activities, :through => :activity_object
  
end
