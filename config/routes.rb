Mandrill::Engine.routes.draw do

  root :to => "email_events#create"
  
  resource :email_events, :controller => 'email_events', :only => [:show,:create]

end

