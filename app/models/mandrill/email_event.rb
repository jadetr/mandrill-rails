module Mandrill
  class EmailEvent < ActiveRecord::Base
    include Mandrill::Models::EmailEventMethods
  end
end
