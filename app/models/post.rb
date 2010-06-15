class Post < ActiveRecord::Base
  attr_accessor :activity_actor
  attr_accessor :activity_wall
  attr_accessor :activity_role

  belongs_to :activity_object
  has_many   :activity_object_activities, :through => :activity_object

  validates_presence_of :activity_actor, :activity_wall, :activity_role

  before_create :create_activity_object

  before_validation :find_activity_contact
  before_create :create_activity
  before_update :update_activity

  private

  def find_activity_contact
    @activity_contact = Contact.where(:actor_from_id => activity_actor.id,
                                      :actor_to_id   => activity_wall.id,
                                      :role_id       => activity_role.id).first
    errors.add_to_base('activity.contact.not_found') unless @activity_contact.present?
  end

  def create_activity
    activity = activity_object.activities.create(:activity_verb => ActivityVerb["post"])

    @activity_contact.activities << activity
  end

end
