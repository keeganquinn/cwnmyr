#--
# $Id: user_observer.rb 361 2007-05-16 00:52:06Z keegan $
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

# This class observes the User model and sends email notifications
# as appropriate with UserNotifier.
class UserObserver < ActiveRecord::Observer
  # This hook sends a signup notification email message when a User instance
  # is successfully created.
  def after_create(user)
    UserNotifier.deliver_signup_notification(user)
  end

  # This hook sends activation and password reset email messages as
  # appropriate when a User instance is successfully saved.
  def after_save(user)
    UserNotifier.deliver_activation(user) if user.recently_activated?
    UserNotifier.deliver_forgot_password(user) if user.recently_forgot?
  end
end
