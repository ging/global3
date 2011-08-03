class Event < ActiveRecord::Base
  include SocialStream::Models::Subject

  has_one :agenda, :dependent => :destroy
  has_many :sessions, :through => :agenda

  attr_accessor :_founder
  attr_accessor :_participants

  delegate :description, :description=, :to => :profile!

  after_create :create_founder
  after_create :create_participants
  
  #acts_as_conference_manager_event
  def profile!
    actor!.profile || actor!.build_profile
  end

  def followers
    contact_subjects(:subject_type => :user, :direction => :received)
  end

  # Creates the ties between the group and the founder
  def create_founder
    founder =
      Actor.find_by_slug(_founder) || raise("Cannot create event without founder")

    sent_contacts.create! :receiver => founder,
                          :relation_ids => Array(relation_customs.sort.first.id)
  end

  # Creates the ties between the group and the participants
  def create_participants
     return if @_participants.blank?

     @_participants.each do |participant|

       participant_actor = Actor.find(participant)

       sent_contacts.create! :receiver => participant_actor,
                             :relation_ids => Array(relation_customs.sort.first.id)
     end
  end
end
