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
  
  def index
    @event = Event.find(params[:event_id])
    
    respond_to do |format|
      format.json { render :text => @event.agenda.sessions.map{ |c| { 'title' => c.name, 'start' => c.start_at, 'end' => c.end_at, 'allDay' => "allDay" } }.to_json }
    end
  end
 
end
