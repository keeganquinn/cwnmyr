#--
# $Id: environment.rb 857 2009-10-24 02:10:32Z keegan $
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

# Rails environment.


# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')


Rails::Initializer.run do |config|
  # Set the default time zone.
  config.time_zone = 'Pacific Time (US & Canada)'

  # Provide a secret for generating integrity hashes for cookie session data.
  config.action_controller.session = {
    :session_key => '_cwnmyr_session',
    :secret => 'AoGBAJlYTYSROQTJuofZUyveMEmsf9U7cRc6/M8j/Hjx5BmzWze6nFURiqw'
  }
  
  # Activate observers that should always be running
  config.active_record.observers = :user_observer

  # Gems
  config.gem 'netaddr', :lib => 'cidr'
  config.gem 'faster_html_escape'
  config.gem 'haml'
  config.gem 'RedCloth'
  config.gem 'rgl', :lib => 'rgl/adjacency'
  config.gem 'rmagick', :lib => 'RMagick'
  config.gem 'validates_as_email_address'
  config.gem 'will_paginate', :version => '~> 2.3.11',
    :source => 'http://gemcutter.org'
end


# Local libraries
require 'dot_diskless'
require 'transforms'

DnsDomain = 'personaltelco.net'
SiteLocator ='https://adhocracy.personaltelco.net/'
SiteEmail = 'webmaster@personaltelco.net'

ExceptionNotifier.sender_address = \
  %("Adhocracy Exception" <rails@adhocracy.personaltelco.net>)
ExceptionNotifier.exception_recipients = [ 'keegan@sniz.net' ]

LinkApplications = {
  'Web page' => 'page',
  'RSS feed' => 'rss'
}

AH_DEFAULT_COUNTRY = 'US'
AH_DEFAULT_STATE = 'OR'
AH_DEFAULT_CITY = 'Portland'

