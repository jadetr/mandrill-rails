module Mandrill
  class EmailEventsController < Mandrill::ApplicationController
    include Mandrill::Rails::WebHookProcessor
    
    def handle_open(event_payload)
            
      email_event = event_payload.as_record
      email_event.save!
      
    end

    def handle_click(event_payload)
      email_event = event_payload.as_record
      email_event.save!
    end
  end
end