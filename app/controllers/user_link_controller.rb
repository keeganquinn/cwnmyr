class UserLinkController < ApplicationController
  before_filter :login_required

  def index
    redirect_to :controller => 'welcome'
  end

  def show
    @user_link = UserLink.find(params[:id])

    unless (current_user == @user_link.user) or @user_link.active?
      redirect_to(:controller => 'welcome') and return
    end

    @page_heading = 'Link: ' + @user_link.name
  end

  def new
    @user_link = UserLink.new(params[:user_link])
    @user_link.user = current_user

    @page_heading = 'New link'

    return unless request.post?

    if @user_link.save
      flash[:notice] = 'Link was successfully created.'
      redirect_to :controller => 'welcome'
    end
  end

  def edit
    @user_link = current_user.links.find(params[:id])

    @page_heading = 'Link: ' + @user_link.name

    return unless request.post?

    if @user_link.update_attributes(params[:user_link])
      flash[:notice] = 'Link was successfully updated.'
      redirect_to :action => 'show', :id => @user_link.id
    end
  end

  def destroy
    current_user.links.find(params[:id]).destroy
    flash[:notice] = 'Link was successfully destroyed.'
    redirect_to :controller => 'welcome'
  end
end
