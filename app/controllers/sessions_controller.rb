class SessionsController < InheritedResources::Base

#before_filter :authenticate_user!

  def new

  end


  def create
    @event = Event.find_by_slug(params[:session][:event_id])
    @agenda=@event.agenda

    @session = Session.new
    @session.title = params[:session][:title]
    @session.description = params[:session][:description]
    @session.start_at = params[:session][:start_at]
    @session.end_at = params[:session][:end_at]
    @session.agenda_id=@event.agenda.id
    @session._contact_id = @agenda._contact_id

    respond_to do |format|
      format.html
    end



  end

=begin
  def create
    if params[:calendar_event][:period] == "Does not repeat"
      @event = CalendarEvent.new(params[:calendar_event])
    else
      #@event_series = EventSeries.new(:frequency => params[:event][:frequency], :period => params[:event][:repeats], :starttime => params[:event][:starttime], :endtime => params[:event][:endtime], :all_day => params[:event][:all_day])
      @event_series = CalendarEventSeries.new(params[:calendar_event])
      if (params[:repeat_until][:year] != "" && params[:repeat_until][:month] != "" && params[:repeat_until][:day] != "")
        @event_series.repeat_until = Date.civil(params[:repeat_until][:year].to_i, params[:repeat_until][:month].to_i, params[:repeat_until][:day].to_i)
        @event_series.save
      end
    end
  end
=end


  def index
    @event = Event.find_by_slug(params[:event_id])

    respond_to do |format|
      #format.json { render :text => @event.agenda.sessions.map{ |c| { 'title' => c.name, 'start' => c.start_at, 'end' => c.end_at, 'allDay' => "allDay" } }.to_json }
      #format.html { @event.agenda.sessions.map{ |c| { 'title' => c.name, 'start' => c.start_at, 'end' => c.end_at, 'allDay' => "allDay" } } }
      format.html
    end
  end
 
end
