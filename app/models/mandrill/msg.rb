require 'date'

module Mandrill
  class Msg < ActiveRecord::Base
    attr_accessible :email, :internal_id, :internal_version, :metadata, :sender, :state, :subject, :tags, :ts, :clicks_attributes, :opens_attributes
    
    belongs_to :email_event
    
    has_many :opens
    has_many :clicks
    
    accepts_nested_attributes_for :opens, :clicks  
    
    def ts=(value)
      write_attribute(:ts, value)
      write_attribute(:ts_dt, DateTime.strptime(value.to_s,'%s'))
    end
    
  end
end
