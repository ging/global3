class LikesController < ApplicationController
  # Assure the suitable contact exists, should be done in Activity model.
  before_filter :contact!, :only => :create

  # POST /activities/1/like.js
  def create
    @like = activity!.children.new :verb => "like"

    respond_to do |format|
      if @like.save
        contact!.activities << @like

        format.js
      else
        format.js
      end
    end
  end


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
