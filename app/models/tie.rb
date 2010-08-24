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

  def set
    self.class.where(:sender_id => sender_id,
                     :receiver_id => receiver_id)
  end

  def relation_set(relations)
    set.where(:relation_id => relations)
  end

  def weaker_set
    relation_set(relation.weaker_and_self)
  end

  def stronger_set
    relation_set(relation.stronger_and_self)
  end

  def group_set(relations = relation)
    self.class.where(:receiver_id => receiver_id,
                     :relation_id => relations)
  end

  after_create :complete_weaker_set

  private

  def complete_weaker_set
    relation.weaker.each do |r|
      if relation_set(r).blank?
        set.create! :relation => r
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
  end
end
