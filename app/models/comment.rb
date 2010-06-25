class Comment < ActiveRecord::Base
  include ActiveRecord::ActivityObject

  validates_presence_of :text

  attr_accessor :activity_contact

  validates_presence_of :activity_contact

  before_create :create_activity
  before_update :update_activity

  private

  def create_activity
    activity = activity_object.activities.create(:activity_verb => ActivityVerb["post"])

    activity_contact.activities << activity
  end
end
