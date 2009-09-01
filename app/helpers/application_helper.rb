module ApplicationHelper
  def title_tag
  end

  def google_analytics analytics_code
    render :partial => 'shared/google_analytics', :locals => {:analytics_code => analytics_code} if RAILS_ENV == 'production'
  end

  # objects_123 # if object is an ActiveRecord
  # foos_123_bars_456 # if object is an array of ActiveRecords
  # prefix_objects_123 #if options[:prefix] == 'prefix'
  def js_id_for object, options = {}
    prefix = options.fetch :prefix, ''
    prefix += '_' unless prefix.blank?

    object = [object] unless object.is_a? Array

    prefix + object.collect {|o| "#{o.class.name.tableize}_#{o.id}"}.join('_')
  end
end
