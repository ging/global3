module ConferenceManager
  module Support
    # This module provides support for Events organized by the ConferenceManger
    module Event
      
      CM_ATTRIBUTES = ["name", "cm_mode", "web_interface", "isabel_interface", "sip_interface", "permalink"]
      
      class << self
        def included(base)
          base.class_eval do

            validate_on_create do |event|
              if event.uses_conference_manager?
                cm_e =
                  ConferenceManager::Event.new(:name => event.name,
                                               :mode => event.cm_mode,
                                               :enable_web => event.web_interface?,
                                               :enable_isabel => event.isabel_interface?,
                                               :enable_sip => event.sip_interface?,
                                               :path => "attachments/conferences/#{event.permalink}")
                begin 
                  cm_e.save
                  event.cm_event_id = cm_e.id
                rescue StandardError => e
                  event.errors.add_to_base(e.to_s)
                end        
              end
            end
           
            validate_on_update do |event|
              if event.uses_conference_manager? && (event.changed & CM_ATTRIBUTES).any? 
                new_params = { :name => event.name,
                               :mode => event.cm_mode,
                               :enable_web => event.web_interface?,
                               :enable_isabel => event.isabel_interface?,
                               :enable_sip => event.sip_interface?,
                               :path => "attachments/conferences/#{event.permalink}" }

                cm_event = event.cm_event
                cm_event.load(new_params)  

                begin
                  cm_event.save
                rescue  StandardError =>e
                  event.errors.add_to_base(e.to_s)  
                end
              end  
            end

            before_destroy do |event|
              if event.uses_conference_manager?
              # Delete event in conference Manager
                begin
                  cm_event = ConferenceManager::Event.find(event.cm_event_id)
                  cm_event.destroy  
                rescue ActiveResource::ResourceNotFound => e
                  true  
                else        
                  true
                end
              end
            end
          end
        end
      end
     
      # The conference manager mode
      def cm_mode
        case vc_mode_sym
        when :meeting
          'meeting'
        when :teleconference
          'conference'
        else
          raise "Unknown Conference Manager mode: #{ vc_mode_sym }"
        end
      end

      def uses_conference_manager?
        case vc_mode_sym
        when :meeting, :teleconference
          true
        else
          false
        end
      end
     
      def cm_event
        begin
          @cm_event ||= ConferenceManager::Event.find(self.cm_event_id)
        rescue
          nil
        end  
      end
      
      def cm_event?
        cm_event.present?
      end

      def web_url
        cm_event.try(:web_url)
      end
      
      def sip_url
        cm_event.try(:sip_url)
      end
      
      def isabel_url
        cm_event.try(:isabel_url) 
      end

      # Returns a String that contains a html with the video of the Isabel Web Gateway
      %w( player editor streaming ).each do |obj|
        eval <<-EOM
      def #{ obj }(width = '640', height = '480')
        begin      
          cm_#{ obj } ||=
            ConferenceManager::#{ obj.classify }.find(:#{ obj },
                                                      :params => { :width => width,
                                                                   :height => height,
                                                                   :event_id => cm_event_id })
          cm_#{ obj }.html 
        rescue
          nil
        end
      end
        EOM
      end

      def web(username, width = '640', height = '480')
        begin      
          cm_web ||=
            ConferenceManager::Web.find(:web,
                                        :params => { :username => username,
                                                     :width => width,
                                                     :height => height,
                                                     :event_id => cm_event_id })
          cm_web.html 
        rescue
          nil
        end
      end
   
      def start!
        ConferenceManager::Start.create(:event_id => cm_event_id)
      rescue  StandardError => e
        errors.add_to_base(e.to_s)  
      end
    end
  end
end
