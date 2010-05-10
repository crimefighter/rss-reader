class AddSettingsToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :settings, :text
  end

  def self.down
    remove_column :feeds, :settings
  end
end
