class BrowseController < ApplicationController

	def index
		 @users = User.all
	end
	
end
