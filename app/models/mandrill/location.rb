module Mandrill
  class Location < ActiveRecord::Base
    attr_accessible :city, :country, :country_short, :latitude, :longitude, :postal_code, :region, :timezone
    
    belongs_to :email_event
    
  end
end
