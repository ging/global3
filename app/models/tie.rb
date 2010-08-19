class Tie < ActiveRecord::Base
  belongs_to :sender,
             :class_name => "Actor",
             :include => [ :user, :space ]
  belongs_to :receiver,
             :class_name => "Actor",
             :include => [ :user, :space ]
  belongs_to :relation

  has_many :activities

  scope :receiver, lambda { |a|
    actor = ( a.is_a?(Actor) ?
              a :
              a.actor )
    where(:receiver_id => actor.id)
  }


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
