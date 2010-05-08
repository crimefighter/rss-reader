module ApplicationHelper
  def google_analytics options = {}
    error_code = options.fetch(:error_code, nil)
    render :partial => 'shared/google_analytics', :locals => {:analytics_code => GOOGLE_ANALYTICS_CODE, :error_code => error_code} if RAILS_ENV == 'production' || !error_code.nil?
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


  #have yield :javascript in your head
  def require_javascript javascript_resource_id
    javascript_resource_id = javascript_resource_id.to_s
    @required_javascript_resources ||= []
    unless @required_javascript_resources.include? javascript_resource_id
      content_for :javascript do 
        "#{javascript_include_tag javascript_resource_id}\n"
      end
      @required_javascript_resources << javascript_resource_id
    end
    ''
  end


  #have yield :css in your head
  def require_css css_resource_id
    css_resource_id = css_resource_id.to_s
    @required_css_resources ||= []
    unless @required_css_resources.include? css_resource_id
      content_for :css do 
        "#{stylesheet_link_tag css_resource_id}\n"
      end
      @required_css_resources << css_resource_id
    end
    ''
  end


  #have yield :meta in your head
  def meta type, content = '', &block
    @meta_tags ||= []
   
    unless @meta_tags.include? type
      content_for :meta do
        "<meta name=\"#{type.to_s}\" content=\"#{h(block.nil? ? content : yield)}\" />\n"
      end
      @meta_tags << type
    end
    ''
  end


  #have title_tag in your head
  def title title
    @title_parts ||= []
    @title_parts.unshift h(title)
    ''
  end


  #same as title, but also writes an h1 tag. Recommended!
  def h1_tag title, html_options = {}
    self.title(title)

    attributes = []

    html_options.each do |key,value|
      attributes << "#{key.to_s}=\"#{value.to_s}\""
    end

    "<h1#{attributes.empty? ? '' : ' '+attributes.join(' ')}>#{h(title)}</h1>"
  end


  #This should be in the head
  def title_tag options = {}
    @title_parts ||= []
    
    @title_parts.unshift options[:prefix] unless options[:prefix].nil?
    @title_parts << options[:suffix] unless options[:suffix].nil?
    separator = options.fetch(:separator, ' &mdash; ')

    "<title>#{@title_parts.join separator}</title>"
  end

  def icon_tag icon
    image_tag "icons/#{icon.to_s}.png", :class => "icon icon_#{icon.to_s}", :size => "16x16"
  end
end
