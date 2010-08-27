class Tie < ActiveRecord::Base
  validates_presence_of :sender_id, :receiver_id, :relation_id

  belongs_to :sender,
             :class_name => "Actor",
             :include => [ :user, :space ]
  belongs_to :receiver,
             :class_name => "Actor",
             :include => [ :user, :space ]
  belongs_to :relation

  has_many :activities

  scope :sender, lambda { |a|
    actor = ( a.is_a?(Actor) ?
              a :
              a.actor )
    where(:sender_id => actor.id)
  }

  scope :receiver, lambda { |a|
    actor = ( a.is_a?(Actor) ?
              a :
              a.actor )
    where(:receiver_id => actor.id)
  }

  scope :with_permissions, includes(:relation => :permissions)

  def sender_subject
    sender.try(:subject)
  end

  def receiver_subject
    receiver.try(:subject)
  end

  # The set of ties between sender and receiver
  #
  def relation_set(r = :nil)
    set = self.class.where(:sender_id => sender_id,
                           :receiver_id => receiver_id)

    case r
    when :nil
      set
    when String
      set.where(:relation_id => relation.class[r])
    else
      set.where(:relation_id => r)
    end
  end

  # The tie with relation r inside this relation_set
  def related(r)
    relation_set(r).first
  end

  # Ties between sender and receiver with a relation weaker or equal to this
  def weaker_set
    relation_set(relation.weaker_and_self)
  end

  # Ties between sender and receiver with a relation stronger or equal to this
  def stronger_set
    relation_set(relation.stronger_and_self)
  end

  # Ties with the same receiver
  def group_set(relations = relation)
    self.class.where(:receiver_id => receiver_id,
                     :relation_id => relations)
  end

  after_create :complete_weaker_set

  def permissions(user, action, object)
    permissions_tie(user, action, object) +
      permissions_weaker_set(user, action, object) +
      permissions_group_set(user, action, object) +
      permissions_weaker_group_set(user, action, object)
  end

  def permission?(user, action, object)
    permissions(user, action, object).any?
  end

  def permissions_tie(user, action, object)
    self.class.sender_permissions(user, action, object).
      where(:sender_id   => sender_id).
      where(:receiver_id => receiver_id).
      where(:relation_id => relation_id).
      where('permissions.parameter' => :tie)
  end

  def permissions_weaker_set(user, action, object)
    self.class.sender_permissions(user, action, object).
      where(:sender_id   => sender_id).
      where(:receiver_id => receiver_id).
      where(:relation_id => relation.stronger_and_self).
      where('permissions.parameter' => :weaker_set)
  end

  def permissions_group_set(user, action, object)
    self.class.sender_permissions(user, action, object).
      where(:receiver_id => receiver).
      where(:relation_id => relation).
      where('permissions.parameter' => :group_set)
  end

  def permissions_weaker_group_set(user, action, object)
    self.class.sender_permissions(user, action, object).
      where(:receiver_id => receiver).
      where(:relation_id => relation.stronger_and_self).
      where('permissions.parameter' => :weaker_group_set)
  end

  private

  def complete_weaker_set
    relation.weaker.each do |r|
      if relation_set(r).blank?
        relation_set.create! :relation => r
      end
    end
  end

  class << self
    def tie_ids_query(actor)
      c = arel_table
      d = c.alias

      c.join(d).
        on(d[:sender_id].eq(actor.id).
        and(c[:receiver_id].eq(d[:receiver_id])).
        and((c[:relation_id].eq(d[:relation_id]).or(c[:relation_id].eq(0))))).
        project(c[:id]).
        to_sql
      "SELECT ties.id FROM ties INNER JOIN ties ties_2 ON ((ties_2.sender_id = #{ actor.id } AND ties_2.receiver_id = ties.receiver_id) AND (ties_2.relation_id = ties.relation_id OR ties.relation_id = #{ Relation['Public'].id }))"

    end

    # Ties with sender including permissions matching action and object
    def sender_permissions(sender, action, object)
      with_permissions.
        sender(sender).
        where('permissions.action' => action).
        where('permissions.object' => object)
    end
  end
end
