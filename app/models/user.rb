class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end
  acts_as_configurable do |c|
    c.boolean :display_full_entries_in_list, :default => true
    c.integer :limit_entries_in_list_to, :default => 0 #0 - no limit
  end
  acts_as_tagger

  has_and_belongs_to_many :feeds

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
end
