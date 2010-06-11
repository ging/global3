class Space < ActiveRecord::Base
  belongs_to :actor,
             :validate => true,
             :autosave => true

  delegate :email, :email=, :to => :actor!

  def actor!
    actor || build_actor
  end
end