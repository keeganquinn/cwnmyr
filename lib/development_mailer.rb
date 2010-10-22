#--
# $Id: development_mailer.rb 452 2007-07-05 10:53:29Z keegan $
# Copyright 2006-2007 Keegan Quinn
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

# 2007.05.24: I don't know the origin of this code; I found it while tidying
# up in config/environments and can't find anything similar on the web.
# Excellent work, in any case.  I'd like to publish it as a plugin.
#
# * Extended to support a configuration hash.
# * Renamed the module.
# * Removed the From: address override.
# * Added the ability to deliver the modified message using any method
#   supported by ActionMailer, also configurable.
#
# (- Keegan)

# An ActionMailer delivery method for developers.
#
# This method forces all outgoing mail to be delivered to a specific
# address, configurable on a per-hostname basis with the
# +developers+ hash.
#
# The actual means of delivering messages can also be configured using
# +real_delivery_method+, which accepts the same options as
# +delivery_method+ in ActionMailer::Base.  Similarly, the settings for
# +perform_deliveries+ and +raise_delivery_errors+ are respected.
#
# To make use of this mailer it must be loaded and configured, usually in
# config/environments/development.rb.  For example:
#
#  require 'development_mailer'
#  ActionMailer::Base.delivery_method = :development
#  ActionMailer::Base.real_delivery_method = :sendmail
#  ActionMailer::Base.developers = {
#    :default => 'qa@company.com',
#    'workstation.company.com' => 'developer@company.com'
#  }
module DevelopmentMailer
  # Processes an email message (+mail+), removing the Cc and Bcc headers and
  # replacing the To header.  The mail is then sent to another delivery
  # method.
  def perform_delivery_development(mail)
    mail.to = developers[Socket.gethostname] || developers[:default]
    mail.cc = ""
    mail.bcc = ""

    # Call the real delivery method as ActionMailer::Base.deliver! would.
    begin
      if perform_deliveries
        send("perform_delivery_#{real_delivery_method}", mail)
      end
    rescue Exception => e  # Net::SMTP errors or sendmail pipe errors
      raise e if raise_delivery_errors
    end
  end
end

# This code should never be loaded in production; say so.
raise "DevelopmentMailer loaded in production" if RAILS_ENV == 'production'

# Tell ActionMailer::Base to include our new module and accessors.
ActionMailer::Base.send(:include, DevelopmentMailer)
ActionMailer::Base.send(:cattr_accessor, :real_delivery_method)
ActionMailer::Base.send(:cattr_accessor, :developers)

# Set default configuration options.
ActionMailer::Base.real_delivery_method = :sendmail
ActionMailer::Base.developers = { :default => 'nobody@localhost' }
