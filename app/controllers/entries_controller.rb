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

    params[:format] = "js" if request.xhr?
    respond_to do |format|
      format.html
      format.js { render :partial => "entries/entry", :collection => @entries, :layout => false }
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def search
    return redirect_to :back if params[:q].blank?
    @entries = current_user.entries.search(params[:q]).paginate(:page => params[:page], :joins => :feed).paginate(:page => params[:page])
    @feeds = current_user.feeds(:joins => :tags).paginate(:page => params[:page])
    params[:format] = "js" if request.xhr?
    respond_to do |format|
      format.html { render :index }
      format.js { render :partial => "entries/entry", :collection => @entries, :layout => false }
    end
  end

  private
  def load_tags
    @all_tags = current_user.owned_tag_counts_from :feeds
    @tags = @all_tags[0...7]
  end
end
