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

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @subscription.destroy
    redirect_to :back
  end

end
