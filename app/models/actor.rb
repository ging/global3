class Actor < ActiveRecord::Base
  has_one :user, :dependent => :destroy
  has_one :space, :dependent => :destroy

  has_many :ties,
           :foreign_key => 'sender_id',
           :include => [ :receiver, :relation ],
           :dependent => :destroy

  def subject
    user || space || activity_object.object
  end
end
