class ActivityObject < ActiveRecord::Base
  has_many :activity_object_activities
  has_many :activities, :through => :activity_object_activities

  has_one :post, :dependent => :destroy
  has_one :video, :dependent => :destroy

  def object
    post || video
  end

end
