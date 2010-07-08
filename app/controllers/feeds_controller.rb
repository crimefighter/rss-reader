class FeedsController < ApplicationController
  def index
    @feeds = case
      when params[:tagged] then current_user.feeds.tagged_with params[:tagged]
      else current_user.feeds :joins => :tags
    end
    @feeds = @feeds.paginate :page => params[:page]
    respond_to do |format|
      format.js do
        render :partial => "feeds/list", :layout => false
      end
    end
  end

  def create
    @feed = Feed.find_by_url(params[:feed][:url])
    if @feed.blank?
      @feed = Feed.create(params[:feed])
      rake! "feeds:refresh", :feed_id => @feed.id
    end
    current_user.feeds << @feed
    current_user.save
    redirect_to entries_path
  end

  def show
    @feed = Feed.find(params[:id])
    @entries = @feed.entries
  end

  def update

  end

  def destroy
  end
end
