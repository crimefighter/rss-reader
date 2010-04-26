class EntriesController < ApplicationController
  def index
    @entries = case
      when params[:feed_id]
        @feed = Feed.find(params[:feed_id])
        @feed.entries
      else Entry.for_user(current_user)
    end
    @entries = @entries.paginate(:page => params[:page])
    @feeds = current_user.feeds
  end

  def show
    @entry = Entry.find(params[:id])
  end

end
