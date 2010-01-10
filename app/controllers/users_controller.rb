class UsersController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :require_no_user, :only => [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.save do |result|
      if result
        flash[:notice] = "Account registered"
        redirect_back_or_default root_url
      else
        render :action => :new
      end
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    @user.attributes.merge(params[:user])

    @user.save do |result|
      if result
        flash[:notice] = "Account updated!"
        redirect_to account_url
      else
        render :action => :edit
      end
    end
  end
end
