require 'date'

module Mandrill
  class EmailEvent < ActiveRecord::Base
    has_one :msg
    has_one :user_agent_parsed
    has_one :location
    
    attr_accessible :event, :internal_id, :ip, :ts, :url, :user_agent, :msg_attributes, :user_agent_parsed_attributes, :location_attributes
    
    accepts_nested_attributes_for :msg, :user_agent_parsed, :location
    
    def ts=(value)
      write_attribute(:ts, value)
      write_attribute(:ts_dt, DateTime.strptime(value.to_s,'%s'))
    end
    
  end
end
