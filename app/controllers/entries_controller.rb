class EntriesController < ApplicationController
  before_filter :load_tags

  def index
    @entries = case
      when params[:tagged]
        @feeds = current_user.feeds.tagged_with params[:tagged]
        Entry.from_feeds @feeds
      when params[:feed_id]
        @feed = Feed.find(params[:feed_id])
        @feed.entries
      else Entry.for_user(current_user)
    end
    @entries = @entries.paginate(:page => params[:page], :joins => :feed)
    @feeds ||= current_user.feeds :joins => :tags
    @feeds = @feeds.paginate :page => params[:page]
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def search
    return redirect_to :back if params[:q].blank?
    @entries = current_user.entries.search(params[:q]).paginate(:page => params[:page], :joins => :feed)
    @feeds = current_user.feeds :joins => :tags
    render :index
  end

  private
  def load_tags
    @tags = current_user.owned_tag_counts[0..10]
  end
end
