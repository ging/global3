class SessionsController < InheritedResources::Base

  before_filter :authenticate_user!

  def new
    @event= Event.find_by_id(@event)

  end

  def create
    @event = Event.find_by_slug(params[:id])

    @session = Session.new ({
      :_contact_id => params[:session][:receiver],
      :title => params[:session][:title],
      :agenda_id => @event.agenda.id,
      :start_at => params[:session][:start_at],
      :end_at =>  params[:session][:end_at],
      :description => params[:session][:description]
    })
    @session.save

    if @event.start_at.nil?
      @event.start_at = params[:session][:start_at]
      @event.end_at =  params[:session][:end_at]
      @event.save
    else
      if @event.start_at > params[:session][:start_at]
        @event.start_at = params[:session][:start_at]
      end
      if @event.end_at < params[:session][:end_at]
        @event.end_at = params[:session][:end_at]
      end
      @event.save
    end

    render :json => @event
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
      @session.save
    end

    if @event.start_at.nil?
      @event.start_at = @session.start_at
      @event.end_at =  @session.end_at
      @event.save
    else
      if @event.start_at > @session.start_at
        @event.start_at = @session.start_at
      end
      if @event.end_at < @session.end_at
        @event.end_at = @session.end_at
      end
      @event.save
    end

    render :json => @session
  end

  def resize
    @session = Session.find(params[:id])
    if @session
      @session.end_at = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@session.end_at))
      @session.save
    end
  end


  def destroy
    @session = Session.find(params[:id])
    start_at=@session.start_at
    end_at=@session.end_at
    @session.destroy


    @event = Event.find(@session.event)

    if !@event.start_at.nil?
      if start_at < @event.start_at
        #@event.start_at = @session.start_at
        #TOCA CAMBIAR FECHA....
      end
      if end_at > @event.end_at
        #@event.end_at = @session.end_at
        #TOCA CAMBIAR FECHA.
      end
      @event.save
    end


    respond_to  :js
  end


  def show
    @event = Event.find_by_slug(params[:id])

  end


 
end
