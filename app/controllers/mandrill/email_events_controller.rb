module Mandrill
  class EmailEventsController < Mandrill::ApplicationController
    include Mandrill::Rails::WebHookProcessor
    
    def handle_open(event_payload)
            
      email_event = event_payload.as_record
      
      
    end

    def handle_click(event_payload)
      EmailEvent.delete_all
      email_event = event_payload.as_record
      ::Rails.logger.ap event_payload
      ::Rails.logger.ap email_event.msg.clicks.first
      email_event.save!
    end
  end
end