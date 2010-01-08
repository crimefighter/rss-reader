class MainController < ApplicationController
  skip_before_filter :require_user

  def index
  end

  #Returns 200 Found if the code is valid, or throws an 404 error otherwise
  def google
    if GOOGLE_WEBMASTER_CODES.include? params[:code]
      head :ok
    else
      raise ActionController::RoutingError.new ''
    end
  end
end
