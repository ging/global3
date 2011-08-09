class AgendasController < InheritedResources::Base
  #protect_from_forgery

  def new

  end

  def create
    @event = Event.find(params[:event_id])
    @agenda = Agenda.new(@event)
  end

  def schedule

  end

  def index

  end

end
