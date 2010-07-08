class SubscriptionsController < ApplicationController
  def update
    @subscription = current_user.subscriptions.find(params[:id])
    if tag_list = params[:subscription].delete(:tag_list)
      current_user.tag(@subscription.feed, :with => tag_list, :on => :tags)
    end
    respond_to do |format|
      format.json if request.xhr?
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to :back }
        format.json { render :json => {:status => 1} }
      else
        format.html { redirect_to :back }
        format.json { render :json => {:status => 0, :errors => @subscription.errors} }
      end
    end
  end

  def import
  end

  def process_imported
    @opml_file = params[:opml_file] or return redirect_to import_subscriptions_path
    @opml_tree = REXML::Document.new(@opml_file.read)
    @subscriptions = {}
    @opml_tree.elements.each('/opml/body/outline') do |tag| 
      tag_name = tag.attributes['title']
      tagged_subscriptions = []
      tag.elements.each('outline') do |subscription|
        tagged_subscriptions << subscription
      end
      feeds = Feed.bulk_find_or_create_from_opml(tagged_subscriptions)
      current_user.subscribe_to feeds, :tag_with => tag_name
    end
    redirect_to entries_path
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @subscription.destroy
    redirect_to :back
  end

end
