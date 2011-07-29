class EventsController < InheritedResources::Base

before_filter :authenticate_user!

  def new
    @event = Event.new
    @subject = @event

    respond_to do |format|
      format.html # new.html.erb
    end

  end
  
  def create
    
    @event = Event.create(params[:event])
    @event._contact_id = current_subject.contact_to!(current_subject).id

    respond_to do |format|
      format.js
    end
    
  end

  def edit
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html # new.html.erb
    end

  end
  
  def update
    update! do |format|
      format.html { render :action => :edit }
    end
    
  end  
  
end
