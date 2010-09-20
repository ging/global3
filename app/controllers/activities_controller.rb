class ActivitiesController < ApplicationController
  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(activities_url) }
      format.xml  { head :ok }
			format.js
    end
	end

end
