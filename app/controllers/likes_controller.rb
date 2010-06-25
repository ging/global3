class LikesController < ApplicationController
  include ActionController::Subactivity

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


end
