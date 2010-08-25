class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Activity do |activity|

      case activity.tie.relation
      when UserToUser
        activity.tie.related('Friend').try(:sender_subject) == user
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
      end
    end

    can :destroy, Activity do |activity|

      case activity.tie.relation
      when UserToUser
        activity.tie.related('Friend').try(:sender_subject) == user
      end
    end
  end

end
