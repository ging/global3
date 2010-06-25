module ActionController
  module Subactivity
    private

    def activity
      @activity ||= Activity.find(params[:activity_id])
    end

    def activity!
      activity || raise(ActiveRecord::RecordNotFound)
    end

    def contact
      @contact ||= current_user.contacts(:actor_to => activity!.author,
                                         :role => activity!.role).first
    end

    def contact!
      contact || raise(ActiveRecord::RecordNotFound)
    end
  end
end
