module Mandrill
  class EmailEventsController < Mandrill::ApplicationController
    include Mandrill::Rails::WebHookProcessor
    
    def handle_open(event_payload)
      #::Rails.logger.ap  event_payload      
      email_event = event_payload.as_record
      handle_email_event_save(email_event)
      
    end

    def handle_click(event_payload)
      email_event = event_payload.as_record
      handle_email_event_save(email_event)
    end
    
    def handle_send(event_payload)
      email_event = event_payload.as_record
      handle_email_event_save(email_event)
    end
    
    def handle_hard_bounce(event_payload)
      email_event = event_payload.as_record
      handle_email_event_save(email_event)
    end
    
    def handle_reject(event_payload)
      email_event = event_payload.as_record
      handle_email_event_save(email_event)
    end
    
    private
    
    def handle_email_event_save(email_event)
      
      begin
        email_event.save
      rescue => ex
        
      end
      
      if email_event.errors.count > 0
        ::Rails.logger.debug email_event.inspect
        ::Rails.logger.debug email_event.errors.inspect
        raise "Cannot save. Error #{email_event.errors.inspect}"
      end
      
    end
    
  end
end