class SessionsController < InheritedResources::Base

  before_filter :authenticate_user!

  def new

  end

  def create
    @event = Event.find_by_slug(params[:session][:event_id])

    @session = Session.new ({
      :_contact_id => params[:session][:receiver],
      :title => params[:session][:title],
      :agenda_id => @event.agenda.id,
      :start_at => params[:session][:start_at],
      :end_at =>  params[:session][:end_at],
      :description => params[:session][:description]
    })
    @session.save
    respond_to do |format|
      format.html
    end
  end

  def index
    @event = Event.find_by_slug(params[:event_id])
    respond_to do |format|
      format.html
    end
  end

  def move
    @session = Session.find_by_id(params[:id])
    if @session
      @session.start_at = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@session.start_at))
      @session.end_at = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@session.end_at))
      #@session.all_day = params[:all_day]
      @session.save
    end
    render :json => @session
    #render :layout => false
  end

  def resize
    @session = Session.find_by_id(params[:id])
    if @session
      @session.end_at = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@session.end_at))
      @session.save
    end
  end


  def destroy
    @session = Session.find_by_id(params[:id])
    if params[:delete_all] == 'true'
      @session.agenda.destroy
    elsif params[:delete_all] == 'future'
      #@sessions = @session.agenda.get_sessions.find(:all, :conditions => ["start_at > '#{@event.starttime.to_formatted_s(:db)}' "])
      #@event.calendar_event_series.calendar_events.delete(@events)
    else
      @session.destroy
    end

    render :update do |page|
      page<<"if (parent.$('#reservation_calendar_events').val()) { parent.$('#reservation_calendar_events').val(parent.$('#reservation_calendar_events').val().replace('#{@event.id}','')) };"
      page<<"$('#calendar').fullCalendar( 'refetchEvents' )"
      page<<"$('#desc_dialog').dialog('destroy')"
    end

  end


  def edit
    @session = Session.find_by_id(params[:id])
  end




 
end
