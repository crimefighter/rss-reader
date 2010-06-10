class Feed < ActiveRecord::Base
  has_many :entries
  acts_as_taggable
  acts_as_configurable do |c|
    c.boolean :headers_only, :default => false
    c.integer :limit_entries_to, :default => 0
    c.boolean :pictures_only, :default => false
    c.boolean :plain_text_only, :default => false
  end
  
  def to_i; id end

  def to_s
    name || url
  end

  def self.per_page
    20
  end

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
