#--
# $Id: user_notifier.rb 620 2007-12-04 11:46:22Z keegan $
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

# This class provides User notification email functionality.
class UserNotifier < ActionMailer::Base
  # This method generates a signup notification email for the
  # provided +user+.
  def signup_notification(user)
    recipients user.email
    from SiteEmail
    subject 'cwnmyr: Please activate your new account'
    body :user => user, :url => SiteLocator + "sessions/create/#{user.activation_code}"
  end

  # This method generates an account activation email for the
  # provided +user+.
  def activation(user)
    recipients user.email
    from SiteEmail
    subject 'cwnmyr: Your account has been activated!'
    body :user => user, :url => SiteLocator
  end

  # This method generates a password reset email for the provided +user+.
  def forgot_password(user)
    recipients user.email
    from SiteEmail
    subject 'cwnmyr: Reset your password'
    body :user => user, :url => SiteLocator + "sessions/create/#{user.activation_code}"
  end
end
