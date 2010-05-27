module ConferenceManager
  class Player < Resource
    singleton
    
    self.element_name = "player" 
    self.site = domain 
    self.prefix = "/events/:event_id/"

    def html
      tag = attributes.inject(""){ |tag, at|
              tag << "#{ at.first }=\"#{ at.last }\" "
            }

      "<embed #{ tag }/>"
    end
  end
end
