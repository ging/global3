class Contact < ActiveRecord::Base
  belongs_to :actor_from,
             :class_name => "Actor",
             :include => [ :user, :space ]
  belongs_to :actor_to,
             :class_name => "Actor",
             :include => [ :user, :space ]
  belongs_to :role

  has_many :contact_activities
  has_many :activities,
           :through => :contact_activities                        

  class << self
    def tie_ids_query(actor)
      c = arel_table
      d = c.alias

      c.join(d).
        on(d[:actor_from_id].eq(actor.id).
        and(c[:actor_to_id].eq(d[:actor_to_id])).
        and((c[:role_id].eq(d[:role_id]).or(c[:role_id].eq(0))))).
        project(c[:id]).
        to_sql
      "SELECT contacts.id FROM contacts INNER JOIN contacts contacts_2 ON ((contacts_2.actor_from_id = #{ actor.id } AND contacts_2.actor_to_id = contacts.actor_to_id) AND (contacts_2.role_id = contacts.role_id OR contacts.role_id = #{ Role.find_by_name('Public').id }))"

    end
  end
end
