class Space < ActiveRecord::Base
  belongs_to :actor,
             :validate => true,
             :autosave => true

  delegate :name, :name=, :email, :email=, :to => :actor!

  validates_presence_of :name

  def actor!
    actor || build_actor
  end
  
  def logo
    "spaces/#{ id % 5 + 1 }.png"
  end
end
