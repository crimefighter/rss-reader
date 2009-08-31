ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'main', :action => 'index'

  map.connect ':code.:format', :controller => 'main', :action => 'google', :code => /google[0-9a-f]{16}/, :format => 'html', :conditions => {:method => :get}
end
