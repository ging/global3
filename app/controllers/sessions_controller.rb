class SessionsController < InheritedResources::Base

before_filter :authenticate_user!

  def new
    @session = Session.new
    @event = Event.find(params[:event_id])

    respond_to do |format|
      format.html # new.html.erb
    end

  end
  
  def create
        
    @event = Event.find(params[:event_id])
    @session = Session.create(params[:session])
    @session._contact_id = current_subject.contact_to!(current_subject).id
    @session.agenda = @event.agenda
    @session.save
    
    respond_to do |format|
      format.js
    end
    
  end
=begin
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
=end  
end
