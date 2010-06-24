class Activity < ActiveRecord::Base

  belongs_to :parent,
             :class_name => "Activity",
             :foreign_key => :parent_id

  has_many :children,
           :class_name => "Activity",
           :foreign_key => :parent_id

  belongs_to :activity_verb
  has_many :activity_object_activities
  has_many :activity_objects, :through => :activity_object_activities

  has_many :contact_activities
  has_many :contacts,
           :through => :contact_activities,
           :include => [ :actor_from ]

  def author
    cs = contacts.map(&:actor_from).uniq
    raise "Activity #{ id } has #{ cs.size } authors" unless cs.size == 1
    cs.first
  end

  def verb
    activity_verb.name
  end

  def verb=(name)
    self.activity_verb = ActivityVerb[name]
  end

  def role
    contacts.first.role
  end

  class << self
    def wall(contacts_query)
      select( "DISTINCT activities.*").
        joins(:contact_activities).
        where("contact_activities.contact_id IN (#{ contacts_query })").
        order("created_at desc")
    end
  end
end
