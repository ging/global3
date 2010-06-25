class Post < ActiveRecord::Base
  include ActiveRecord::ActivityObject

  attr_accessor :author
# attr_accessor :activity_actor_id
  attr_accessor :activity_wall_id
  attr_accessor :activity_role_id

  validates_presence_of :author, :activity_wall_id, :activity_role_id

  before_create :create_activity
  before_update :update_activity

  validate :validate_activity_contact

  private

  def validate_activity_contact
    errors[:base ] << ('activity.contact.not_found') unless activity_contact.present?
  end

  def activity_contact
    @activity_contact ||= Contact.where(:actor_from_id => author.actor.id,
                                        :actor_to_id   => activity_wall_id,
                                        :role_id       => activity_role_id).first
  end

  def create_activity
    activity = activity_object.activities.create(:activity_verb => ActivityVerb["post"])

    @activity_contact.activities << activity
  end
end
