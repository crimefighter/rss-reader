module EntriesHelper
  def entry_content entry
    feed_options = entry.feed.options_for(current_user) and content = entry.content
    case feed_options.view_mode.try :to_sym
      when :headers_only then nil
      when :pictures_only then fetch_pictures(content)
      when :plain_text_only then plain_text(content)
      else content
    end
  end

  def fetch_pictures content
    imgs = content.scan(/<\s*img [^\>]*src\s*=\s*(["\'])(.*?)\1/i).map do |img|
      "<p><img src=\"#{img.last}\" /></p>"
    end
    imgs.join
  end

  def plain_text content
    sanitize(content, :tags => %w(p ul ol li br))
  end
end
