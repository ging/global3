class Actor < ActiveRecord::Base
  has_one :user, :dependent => :destroy
  has_one :space, :dependent => :destroy

  has_many :contacts,
           :foreign_key => 'actor_from_id',
           :include => [ :actor_to, :role ],
           :dependent => :destroy

  def subject
    user || space || activity_object.object
  end
end
