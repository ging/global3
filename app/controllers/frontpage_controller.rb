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

class FrontpageController < ApplicationController
  before_filter :redirect_user_to_home, :only => :index

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spaces }
      format.atom
    end
  end
  
  def about
    @global = Space.find_by_name("GLOBAL")
    @latest_global_posts = Post.last_news(@global)
    render :layout=>false
  end
  

  
  def about2   
    render :layout=>false
  end

  private

  def redirect_user_to_home
    redirect_to(home_path) if user_signed_in?
  end
end
