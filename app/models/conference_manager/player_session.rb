module ConferenceManager
  class PlayerSession < Resource
    singleton
   
    self.element_name = "player" 
    self.site = domain
    self.prefix = "/events/:event_id/sessions/:session_id/" 

    def html
      tag = attributes.inject(""){ |tag, at|
              tag << "#{ at.first }=\"#{ at.last }\" "
            }

      "<embed #{ tag }/>"
    end
  end
end
