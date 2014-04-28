module Mandrill
  class UserAgentParsed < ActiveRecord::Base
    attr_accessible :mobile, :os_company, :os_company_url, :os_family, :os_icon, :os_name, :os_url, :type, :ua_company, :ua_company_url, :ua_family, :ua_icon, :ua_name, :ua_url, :ua_version
    
    belongs_to :email_event
    
  end
end
