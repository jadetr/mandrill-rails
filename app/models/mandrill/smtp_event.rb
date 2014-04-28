require 'date'

module Mandrill
  class SmtpEvent < ActiveRecord::Base
    belongs_to :msg
    attr_accessible :destination_ip, :diag, :size, :source_ip, :ts, :ts_dt, :type
    
    def ts=(value)
      write_attribute(:ts, value)
      write_attribute(:ts_dt, DateTime.strptime(value.to_s,'%s'))
    end
    
  end
end
