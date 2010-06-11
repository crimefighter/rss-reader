ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'main', :action => 'index'

  map.resources :entries, :collection => [:search]
  map.resources :feeds, :has_many => :entries
  map.resources :subscriptions, :only => [:update, :destroy]

  # routes for session control
  map.signin '/signin', :controller => 'user_sessions', :action => 'new', :conditions => {:method => :get}
  map.create_user_session '/signin', :controller => 'user_sessions', :action => 'create', :conditions => {:method => :post}
  map.signout '/signout', :controller => 'user_sessions', :action => 'destroy' 

  # routes for sign up
  map.signup '/signup', :controller => 'users', :action => 'new', :conditions => {:method => :get}
  map.create_user '/signup', :controller => 'users', :action => 'create', :conditions => {:method => :post}

  # routes for editing your own account
  map.account '/account', :controller => 'users', :action => 'edit', :conditions => {:method => :get}
  map.update_user '/account', :controller => 'users', :action => 'update', :conditions => {:method => :post}

  # routes for browsing all users (if there is such a feature)
  # map.resources :users

  map.connect ':code.:format', :controller => 'main', :action => 'google', :code => /google[0-9a-f]{16}/, :format => 'html', :conditions => {:method => :get}
end
