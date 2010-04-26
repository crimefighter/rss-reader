class Entry < ActiveRecord::Base
  belongs_to :feed
  validates_presence_of :url, :title, :feed_id, :item_id
  validates_uniqueness_of :item_id, :scope => :feed_id

  default_scope :order => "created_at DESC"
  
  named_scope :for_user, lambda {|u| {:conditions => {:feed_id => u.feeds.map(&:id)}}}

  xss_terminate :except => [ :content ]

  def per_page; 20 end
end
