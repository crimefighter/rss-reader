class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def create
    @feed = Feed.find_by_url(params[:feed][:url])
    if @feed.blank?
      @feed = Feed.create(params[:feed])
      @feed.fetch_entries
    end
    current_user.feeds << @feed
    current_user.save
    redirect_to entries_path
  end

  def show
    @feed = Feed.find(params[:id])
    @entries = @feed.entries
  end

  def destroy
  end

end
