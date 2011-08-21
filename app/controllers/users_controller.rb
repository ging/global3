class UsersController < InheritedResources::Base
def index
    @users = User.alphabetic.
                  letter(params[:letter]).
                  search(params[:search]).
                  tagged_with(params[:tag]).
                  page(params[:page]).per(10)

    index! do |format|
      format.html { render :layout => (user_signed_in? ? 'application' : 'frontpage') }
    end
  end
end
