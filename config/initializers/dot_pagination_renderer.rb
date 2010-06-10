class DotPaginationRenderer < WillPaginate::LinkRenderer

  def to_html
    links = @options[:page_links] ? windowed_links : []
    html = links.join(@options[:separator])
    @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
  end

protected

  def page_link(page, text, attributes = {})
    link_path = if page_link_path = @options[:page_link_path]
      page_link_path[:page] = page
      page_link_path
    else
      url_for(page)
    end
    @template.link_to("&bull;", page_link_path, attributes)
  end

  def page_span(page, text, attributes = {})
    @template.content_tag(:span, "&bull;", attributes)
  end

end
