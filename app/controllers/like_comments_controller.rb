class LikeCommentsController < ApplicationController
  include ActionController::Subactivity

  # Assure the suitable tie exists, should be done in Activity model.
  before_filter :tie!, :only => :create

  # POST /activities/1/like.js
  def create
    @like = activity!.children.new :verb => "like"

    respond_to do |format|
      if @like.save
        tie!.activities << @like
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    if (@like = activity!.liked_by(current_user).first)
      @like.destroy
    end

    respond_to do |format|
      format.js
    end
  end
end
