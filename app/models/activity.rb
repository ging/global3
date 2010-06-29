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

  belongs_to :contact,
             :include => [ :actor_from ]
  has_one :author,
          :through => :contact,
          :source => :actor_from
  has_one :wall,
          :through => :contact,
          :source => :actor_to
  has_one :role,
          :through => :contact

  def verb
    activity_verb.name
  end

  def verb=(name)
    self.activity_verb = ActivityVerb[name]
  end

  def comments
    children.includes(:activity_objects).where('activity_objects.object_type' => "Comment")
  end

  class << self
    def wall(contacts_query)
      select( "DISTINCT activities.*").
        where("activities.contact_id IN (#{ contacts_query })").
        order("created_at desc")
    end
  end
end
