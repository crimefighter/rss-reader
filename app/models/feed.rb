class Feed < ActiveRecord::Base
  has_many :entries
  has_many :subscriptions, :dependent => :destroy
  has_many :users, :through => :subscriptions
  acts_as_taggable
  
  def to_i; id end

  def to_s
    name || url
  end

  @@per_page = 20
  @@top_bar_tags = 7
  @@refresh_rate = 1.hour
  cattr_reader :per_page, :top_bar_tags, :refresh_rate

  def self.bulk_find_or_create_from_opml opml_feeds
    feeds = []
    opml_feeds.each do |opml_feed|
      feeds << if feed = Feed.find_by_url(opml_feed.attributes['xmlUrl'])
        feed
      else
        feed = Feed.create(:url => opml_feed.attributes['xmlUrl'], :name => opml_feed.attributes['title'])
      end
    end
    feeds
  end

  def options_for(user)
    self.subscriptions.find_by_user_id(user.id)
  end

  def refresh options = nil
    options ||= {}
    return unless (updated_at < Feed.refresh_rate.ago) or options.fetch(:force, false)
    fetch_entries
  end

  protected

  def fetch_entries
    feed_xml = FeedNormalizer::FeedNormalizer.parse open url rescue nil
    if feed_xml.blank?
      discover_feed_and_fetch_entries
      return
    end
    entries_params = feed_xml.entries

    unless self.entries.count == 0
      entries_params.reject! {|entry_xml| entry_xml.last_updated < self.updated_at } 
    end

    entries_params = entries_params.map do |entry_xml| 
      { :item_id => entry_xml.id,
        :title => entry_xml.title, 
        :url => entry_xml.url, 
        :content => entry_xml.content }
    end
    entries.create entries_params.compact

    if self.name.blank?
      self.update_attributes(:name => feed_xml.title) #set feed name if not set
    else
      self.touch #set updated_at
    end
  end

  def discover_feed_and_fetch_entries
    urls = Feedbag.find url
    return if urls.blank?
    update_attributes(:url => urls.first) and fetch_entries
  end
end
