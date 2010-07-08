namespace :feeds do
  task :refresh => :environment do
    feed = Feed.find(ENV["FEED_ID"])
    feed.refresh
  end

  task :refresh_selected => :environment do
    feeds = Feed.find_all_by_id(ENV["FEED_IDS"].split(","))
    feeds.map(&:refresh)
  end

  task :refresh_all => :environment do
    Feed.all.map(&:refresh)
  end
end
