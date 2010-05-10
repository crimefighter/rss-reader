module EntriesHelper
  def entry_content entry
    feed = entry.feed and content = entry.content
    case
      when feed.headers_only?
        nil
      when feed.pictures_only?
        fetch_pictures content
      when feed.plain_text_only?
        feed.limit_entries_to.to_i == 0 ? plain_text(content) : truncate(plain_text(content), feed.limit_entries_to.to_i)
      else
        feed.limit_entries_to.to_i == 0 ? content : truncate_html(content, feed.limit_entries_to.to_i)
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
