#--
# $Id: authenticated_system.rb 463 2007-07-08 15:29:10Z keegan $
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

# The AuthenticatedSystem module provides a number of methods to simplify
# management of web user login sessions. These methods are available to all
# controllers.
#
# See ApplicationController and AuthenticatedTestHelper for more information.
module AuthenticatedSystem
  protected

  # Accesses the current User from the session.
  def current_user
    @current_user ||= session[:user] ? User.find_by_id(session[:user]) : nil
  end

  # Store the given User in the session.
  def current_user=(new_user)
    session[:user] = new_user.nil? ? nil : new_user.id
    @current_user = new_user
  end

  # Alternate method for accessing the current User from the session.
  def logged_in?
    current_user
  end

  # Override this if you want to restrict access to only a few actions,
  # or if you want to check if the User has the correct rights.
  #
  # Example:
  #
  #  # only allow nonbobs
  #  def authorize?(user)
  #    user.login != "bob"
  #  end
  def authorized?(user)
    true
  end

  # Override this method if you only want to protect certain actions
  # of the controller.
  #
  # Example:
  # 
  #  # don't protect the login and the about method
  #  def protect?(action)
  #    if ['action', 'about'].include?(action)
  #       return false
  #    else
  #       return true
  #    end
  #  end
  def protect?(action)
    true
  end

  # To require logins, use:
  #
  #   before_filter :login_required
  #   before_filter :login_required, :only => [:edit, :update]
  # 
  # To skip this in a subclassed controller:
  #
  #   skip_before_filter :login_required
  # 
  def login_required
    # skip login check if action is not protected
    return true unless protect?(action_name)

    # check if user is logged in and authorized
    return true if logged_in? and authorized?(current_user)

    # store current location so that we can 
    # come back after the user logged in
    store_location

    # call overwriteable reaction to unauthorized access
    access_denied and return false
  end

  # Override this method if you want to have special behavior in
  # case the user is not authorized to access the current operation. 
  # The default action is to redirect to the login screen.
  def access_denied
    redirect_to new_session_path
  end  

  # Store the current URI in the session.
  # We can return to this location by calling return_location.
  def store_location
    session[:return_to] = request.request_uri
  end

  # Move to the URI from the last store_location call or to the
  # passed default URI.
  def redirect_back_or_default(location = welcome_path)
    if session[:return_to]
      location = session[:return_to]
      session[:return_to] = nil
    end

    redirect_to location
  end

  # Adds ActionView helper methods upon inclusion.
  def self.included(base)
    base.send :helper_method, :current_user, :logged_in?
  end
end
