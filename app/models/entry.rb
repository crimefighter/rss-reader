class Entry < ActiveRecord::Base
  belongs_to :feed
  validates_presence_of :url, :title, :feed_id, :item_id
  validates_uniqueness_of :item_id, :scope => :feed_id

  default_scope :order => "created_at DESC"
  
  named_scope :for_user, lambda {|u| {:conditions => {:feed_id => u.feeds.map(&:id)}}}
  named_scope :from_feeds, lambda {|feeds| {:conditions => {:feed_id => feeds.to_a.map(&:to_i)}}}

  xss_terminate :except => [ :content ]

  index do
    title
    content
  end

  def per_page; 20 end

  def self.from_feeds_tagged_with tag_list, options = nil
    options ||= {}
    tagger = options.fetch(:by, nil)
    feed_scope = tagger.feeds || Feed
    feeds = feed_scope.tagged_with tag_list
    self.find_all_by_feed_id(feeds.map(&:id))
  end
end
