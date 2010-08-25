class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Activity do |a|
      # All ties authors must the user
      a.tie.sender_subject == user &&
        case a.tie.relation
        when UserToUser
          Tie.sender(user).receiver(a.tie.receiver).where(:relation_id => Relation['Friend']).present?
        when UserToSpace
          ['Admin', 'User'].include?(a.tie.relation.name) ||
            Tie.sender(user).receiver(a.tie.receiver).where(:relation_id => Relation['User']).present?
        end
    end

    can :read, Activity do |activity|

      case activity.tie.relation
      when UserToUser, UserToSpace
        activity.tie.group_set.sender(user).present?
      end
    end

    can :update, Activity do |activity|

      case activity.tie.relation
      when UserToUser
        activity.tie.related('Friend').try(:sender_subject) == user
      when UserToSpace
        case activity.tie.relation.name
        when 'Admin'
          activity.tie.group_set.sender(user).present?
        else
          activity.tie.relation_set('User').sender(user).present?
        end
      end
    end

    can :destroy, Activity do |activity|

      case activity.tie.relation
      when UserToUser
        activity.tie.related('Friend').try(:sender_subject) == user
      when UserToSpace
        case activity.tie.relation.name
        when 'Admin'
          activity.tie.group_set.sender(user).present?
        else
          activity.tie.relation_set('User').sender(user).present?
        end
      end
    end
  end
end
