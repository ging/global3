class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Activity do |activity|

      case activity.tie.relation
      when UserToUser, UserToSpace
        activity.tie.group_set.sender(user).present?
      end
    end

    can :update, Activity do |activity|

      case activity.tie.relation
      when UserToUser
        activity.tie.sender == user
      end
    end

    can :destroy, Activity do |activity|

      case activity.tie.relation
      when UserToUser
        activity.tie.sender == user
      end
    end
  end
end
