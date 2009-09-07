class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  before_filter :check_if_maintenance

#  unless  ActionController::Base.consider_all_requests_local
    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, ActionController::UnknownController, ActionController::UnknownAction, :with => :render_404
    rescue_from RuntimeError, :with => :render_500
#  end

private

  def check_if_maintenance
    render :template => 'error_pages/503', :layout => false, :status => :service_unavailable if File.exists? RAILS_ROOT + '/tmp/maintenance.txt'
  end

  def render_404
    render :template => 'error_pages/404', :layout => false, :status => :not_found
  end

  def render_500
    render :template => 'error_pages/505', :layout => false, :status => :internal_server_error
  end

end
