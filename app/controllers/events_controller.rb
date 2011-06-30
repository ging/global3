class EventsController < InheritedResources::Base

before_filter :authenticate_user!

  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
    end

  end
  
  def create
    
    @event = Event.create(params[:event])
    debugger
    #@event.contact = current_subject.contact_to!(current_subject)
    redirect_to events_new_path
  end

end
