class EntriesController < ApplicationController
  def index
    @entries = case
      when params[:tagged]
        @feeds = Feed.tagged_with params[:tagged]
        Entry.from_feeds @feeds
      when params[:feed_id]
        @feed = Feed.find(params[:feed_id])
        @feed.entries
      else Entry.for_user(current_user)
    end
    @entries = @entries.paginate(:page => params[:page], :joins => :feed)
    @feeds ||= current_user.feeds :joins => :tags
    @tags = current_user.owned_tag_counts
  end

  def show
    @entry = Entry.find(params[:id])
  end
end
