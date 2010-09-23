class SpacesController < ApplicationController

	def index
		
	end

  def show
    @space = Space.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @space }
    end
	end

end
