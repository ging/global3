# Copyright 2008-2010 Universidad Politécnica de Madrid and Agora Systems S.A.
#
# This file is part of VCC (Virtual Conference Center).
#
# VCC is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# VCC is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with VCC.  If not, see <http://www.gnu.org/licenses/>.

class AgendaDividersController < ApplicationController
  include ActionController::StationResources
  
  before_filter :space!
  before_filter :event
  
  authorization_filter :create, :agenda_divider, :only => [ :new, :create ]
  authorization_filter :read,   :agenda_divider, :only => [ :show, :index ]
  authorization_filter :update, :agenda_divider, :only => [ :edit, :update ]
  authorization_filter :delete, :agenda_divider, :only => [ :destroy ]
  
  
  def index
    raise ActiveRecord::RecordNotFound    
  end
  
  
  # GET /agenda_dividers/new
  # GET /agenda_dividers/new.xml
  def new
     @agenda_divider = AgendaDivider.new
     @day=params[:day]     

  end
  
  # POST /agenda_dividers
  # POST /agenda_dividers.xml
  def create
    @agenda_divider = AgendaDivider.new(params[:agenda_divider])

    @agenda_divider.agenda = @event.agenda
    
    respond_to do |format|
      if @agenda_divider.save
        format.html {redirect_to(space_event_path(@space, @event, :show_day=>@agenda_divider.event_day, :anchor=>"edit_entry_anchor" )) }
      else    
        flash[:notice] = t('agenda.divider.failed')
        message = ""
        @agenda_divider.errors.full_messages.each {|msg| message += msg + "  <br/>"}
        flash[:error] = message
        format.html { redirect_to(space_event_path(@space, @event)) }
      end
    end
  end
  
  # GET /agenda_dividers/1/edit
  def edit
    @agenda_divider = AgendaDivider.find(params[:id])
    @day=@agenda_divider.event_day
  end
  
  
  # PUT /agenda_dividers/1
  # PUT /agenda_dividers/1.xml
  def update
    @agenda_divider = AgendaDivider.find(params[:id])
    
    respond_to do |format|
      if @agenda_divider.update_attributes(params[:agenda_divider])        
        flash[:notice] = t('agenda.divider.updated')
        day = @agenda_divider.event_day
        format.html { redirect_to(space_event_path(@space, @event, :show_day => day) ) }
      else
        message = ""
        @agenda_divider.errors.full_messages.each {|msg| message += msg + "  <br/>"}
        flash[:error] = message
        format.html { redirect_to(space_event_path(@space, @event)) }
      end
    end
  end
  
  # DELETE /agenda_dividers/1
  # DELETE /agenda_dividers/1.xml
  def destroy
    @agenda_divider = AgendaDivider.find(params[:id])
    day = @agenda_divider.event_day
    agenda = @agenda_divider.agenda
    respond_to do |format|
      if @agenda_divider.destroy
        flash[:notice] = t('agenda.divider.delete')
        if agenda.contents_for_day(day).blank?
          format.html { redirect_to(space_event_path(@space, @event, :show_day => 1)) }
        else
          format.html { redirect_to(space_event_path(@space, @event, :show_day => day)) }
        end
        format.xml  { head :ok }
      else
        message = ""
        @agenda_divider.errors.full_messages.each {|msg| message += msg + "  <br/>"}
        flash[:error] = message
        format.html { redirect_to(space_event_path(@space, @event)) }
      end
    end  
    
  end
  
  
  private
  
  def event
    @event = Event.find_by_permalink(params[:event_id]) || raise(ActiveRecord::RecordNotFound)
  end
  
  # Redefining path_container method from Station as the container (Agenda) does not have
  # its ID in the path because Event has_one Agenda instead of has_many
  def path_container(options = {})
    if (options[:type]).nil? || (options[:type] == Agenda)
      return event.agenda
    else
      super
    end
  end
  
end