class EventsController < InheritedResources::Base
  # Set group founder to current_subject
  # Must do before authorization
  #before_filter :authenticate_user!

  before_filter :set_founder, :only => :create

  #load_and_authorize_resource

  #respond_to :html, :js


  def create
    create! do |success, failure|
      success.html {
        self.current_subject = @event
        redirect_to [current_subject, :profile]
      }
    end
  end


  def edit
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

=begin
  def index
    @events = Event.all

    respond_to do |format|
      format.html
    end
  end
=end

  def index
    @events = Event.most(params[:most]).
                    alphabetic.
                    letter(params[:letter]).
                    search(params[:search]).
                    tagged_with(params[:tag]).
                    page(params[:page]).per(10)
  end


=begin
  def new
    @event = Event.new
    @subject = @event

    respond_to do |format|
      format.html # new.html.erb
    end
  end


  def update
    update! do |format|
      format.html { render :action => :edit }
    end
  end



  def show
    @event =  Event.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
=end


  protected

  # Overwrite resource method to support slug
  # See InheritedResources::BaseHelpers#resource
  def resource
    @event ||= end_of_association_chain.find_by_slug!(params[:id])
  end

  private

  def set_founder
    return unless user_signed_in?

    params[:event]            ||= {}
    params[:event][:_founder] ||= current_subject.slug
  end

end
