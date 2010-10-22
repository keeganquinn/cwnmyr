#--
# $Id: sessions_controller.rb 513 2007-07-18 18:23:16Z keegan $
# Copyright 2004-2007 Keegan Quinn
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#++

# This controller allows a User to create or destroy an
# authenticated session.
class SessionsController < ApplicationController
  before_filter :hide_nav
  skip_before_filter :track_location

  # Display a form to allow a User to provide credentials, or redirects to
  # WelcomeController if an authenticated session is already active.
  def new
    return redirect_to(welcome_path) if logged_in?
  end

  # The create action accepts either an activation code or a set of
  # credentials to authenticate a User and create a session for further
  # authorization.  It redirects to WelcomeController if an authenticated
  # session is already active.
  def create
    return redirect_to(welcome_path) if logged_in?

    if params[:id]
      @user = User.find_by_activation_code(params[:id])
      @user.activate @user.activated_at.blank?
      flash[:notice] = t('account activated')
    end

    respond_to do |format|
      if @user ||= User.authenticate(params[:login], params[:password])
        self.current_user = @user
        flash[:notice] ||= t('authentication success')

        format.html { redirect_back_or_default }
        format.xml  { head :ok }
        format.js   { send_js 'login_response' }
      else
        flash[:warning] = t('authentication fail')

        format.html { render :action => :new }
        format.xml  { render :xml => flash.to_xml }
        format.js   { send_js 'login_response' }
      end
    end
  end

  # The destroy action destroys any current authenticated session and
  # redirects to WelcomeController.
  def destroy
    self.current_user = nil
    flash[:notice] = t('session destroyed')

    redirect_back_or_default welcome_path
  end
end
