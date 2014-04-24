module Mandrill
  class Event < ActiveRecord::Base
    belongs_to :msg
    belongs_to :user_agent_parsed
    belongs_to :location
    attr_accessible :event_name, :internal_id, :ip, :ts, :url, :user_agent
  end
end
