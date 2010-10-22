#--
# $Id: application_controller.rb 853 2009-10-24 01:34:35Z keegan $
# Copyright 2004-2009 Keegan Quinn
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

# All controller classes are subclasses of ApplicationController.
#
# Filters added to this controller apply to all controllers in the
# application.  Likewise, all the methods added will be available for all
# controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable

  before_filter :set_timezone
  before_filter :user_locale
  before_filter :track_location

  protected

  # Get the locale from the session if it has been set.
  def user_locale
    I18n.locale = session[:locale]
  end

  # Store the current location unless the user is logged in.
  def track_location
    store_location unless logged_in?
  end

  # Set the time zone from the User record if possible.
  def set_timezone
    if logged_in? and !current_user.time_zone.blank?
      Time.zone = current_user.time_zone
    end
  end

  # Do not automatically generate navigation links for this request. This
  # method is usually called as a before_filter.
  def hide_nav
    @hide_nav = true
  end

  # Simplify the creation of dynamic JavaScript responses.
  def send_js(target, partial = 'layouts/messages')
    render :update do |page|
      page.replace_html target, :partial => partial
      page.visual_effect :highlight, target
    end
    flash.discard
  end
end
