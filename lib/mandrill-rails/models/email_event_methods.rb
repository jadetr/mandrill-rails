require 'date'

module Mandrill
  module Models
    module EmailEventMethods
      def self.included(base)
        # Associations
        base.send :has_one, :msg
        base.send :has_one, :user_agent_parsed
        base.send :has_one, :location
        
        # Whitelisting attributes
        base.send :attr_accessible, :event, :internal_id, :ip, :ts, :url, :user_agent, :msg_attributes, :user_agent_parsed_attributes, :location_attributes
        
        base.send :accepts_nested_attributes_for, :msg, :user_agent_parsed, :location
        
      end
      
      def ts=(value)
        write_attribute(:ts, value)
        write_attribute(:ts_dt, DateTime.strptime(value.to_s,'%s'))
      end
      
    end
  end
end