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

  def update
    @feed = Feed.find(params[:id])
    if tag_list = params[:feed].delete(:tag_list)
      current_user.tag(@feed, :with => tag_list, :on => :tags)
    end
    respond_to do |format|
      format.json if request.xhr?
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to :back }
        format.json { render :json => {:status => 1} }
      else
        format.html { redirect_to :back }
        format.json { render :json => {:status => 0, :errors => @feed.errors} }
      end
    end
  end

  def destroy
  end
end
