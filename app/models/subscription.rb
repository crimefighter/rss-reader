class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  acts_as_configurable do |c|
    c.boolean :headers_only, :default => false
    c.integer :limit_entries_to, :default => 0
    c.boolean :pictures_only, :default => false
    c.boolean :plain_text_only, :default => false
  end
end
