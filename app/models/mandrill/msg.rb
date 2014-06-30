require 'date'

module Mandrill
  class Msg < ActiveRecord::Base
    attr_accessible :email, :internal_id, :internal_version, :metadata, :resends, :subaccount, :reject, :template, :sender, :state, :subject, :tags, :ts, :clicks_attributes, :opens_attributes, :smtp_events_attributes
    
    belongs_to :email_event
    
    has_many :opens
    has_many :clicks
    has_many :smtp_events
    
    accepts_nested_attributes_for :opens, :clicks, :smtp_events   
    
    def ts=(value)
      write_attribute(:ts, value)
      write_attribute(:ts_dt, DateTime.strptime(value.to_s,'%s'))
    end
    
  end
end
