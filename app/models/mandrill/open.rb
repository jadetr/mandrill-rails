require 'date'

module Mandrill
  class Open < ActiveRecord::Base
    belongs_to :msg
    attr_accessible :ts
    
    def ts=(value)
      write_attribute(:ts, value)
      write_attribute(:ts_dt, DateTime.strptime(value.to_s,'%s'))
    end
    
  end
end
