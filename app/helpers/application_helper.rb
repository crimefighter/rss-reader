module ApplicationHelper
  def google_analytics(analytics_code)
    render :partial => 'shared/google_analytics', :locals => {:analytics_code => analytics_code} if RAILS_ENV == 'production'
  end
end
