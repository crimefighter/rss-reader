class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end
  acts_as_configurable do |c|
    c.boolean :display_full_entries_in_list, :default => true
    c.integer :limit_entries_in_list_to, :default => 0 #0 - no limit
  end
  acts_as_tagger

  has_many :subscriptions
  has_many :feeds, :through => :subscriptions

  def to_s
    email
  end

  def owned_tag_counts_from entity, options = nil
    options ||= {}
    context = options.fetch(:on, :tags)
    return unless self.respond_to? entity
    self.send(entity).tag_counts_on(context, :conditions => {"taggings.tagger_type" => self.class.name, "taggings.tagger_id" => self.id})
  end

  def entries
    Entry.scoped :conditions => {:feed_id => self.feed_ids}
  end

  def subscribed? feed
    subscriptions.find_by_feed_id(feed.to_i)
  end

  def subscribe_to feed_or_feeds, options=nil
    options ||= {}
    tag_list = options.fetch(:tag_with, nil)
    feeds = feed_or_feeds.to_a.reject {|feed| subscribed? feed }
    feeds.each do |feed|
      subscriptions.create(:feed => feed)
      tag feed, :with => tag_list, :on => :tags unless tag_list.blank?
    end
  end
end
