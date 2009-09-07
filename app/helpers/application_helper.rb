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


  def require_javascript javascript_resource_id
    @required_javascript_resources ||= []
    unless @required_javascript_resources.include? javascript_resource_id
      content_for :javascript do 
        "#{javascript_include_tag javascript_resource_id}\n"
      end
      @required_javascript_resources << javascript_resource_id
    end
    ''
  end

  def require_css css_resource_id
    @required_css_resources ||= []
    unless @required_css_resources.include? css_resource_id
      content_for :css do 
        "#{stylesheet_link_tag css_resource_id}\n"
      end
      @required_css_resources << css_resource_id
    end
    ''
  end
end
