class AgendasController < InheritedResources::Base
  #protect_from_forgery

  def schedule

  end

  def index

  end

  def get_sessions
    @event = Event.find_by_slug(params[:id])
    agenda = @event.agenda

    time_start=Time.at(params['start'].to_i)
    time_end=Time.at(params['end'].to_i)
    @sessions = agenda.sessions.where( "start_at >= '#{time_start.to_formatted_s(:db)}' AND
                             end_at  <= '#{time_end.to_formatted_s(:db)}' ")
    sessions = []
    @sessions.each do |session|
      sessions << {:id => session.id,
                   :title => session.title,
                   :description => session.description || "Some cool description here...",
                   :start => "#{session.start_at.iso8601}",
                   :end => "#{session.end_at.iso8601}",
                   :allDay => false,
                   :recurring =>  false,
                   :editable => true
                  }
    end
    render :text => sessions.to_json

  end

end


