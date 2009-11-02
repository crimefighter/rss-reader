class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  
  protect_from_forgery

  before_filter :check_if_maintenance
  before_filter :require_user # require implicit enabling of pages for non-registered users

  unless  ActionController::Base.consider_all_requests_local
    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, ActionController::UnknownController, ActionController::UnknownAction, :with => :render_404
    rescue_from RuntimeError, :with => :render_500
  end

  
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

  #Authlogic helpers
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
