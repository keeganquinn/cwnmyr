#--
# $Id: test_helper.rb 855 2009-10-24 02:09:07Z keegan $
# Copyright 2004-2008 Keegan Quinn
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

ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'authenticated_test_helper'

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...
  include AuthenticatedTestHelper
  include MimeTest::Assertions
end


# Assertion which checks to be sure the result of a method call on
# an object changes while executing a block.
def assert_change(object, method, difference = nil)
  initial_value = object.send(method)
  yield
  object.reload if object.respond_to?(:reload)

  if difference
    assert_equal initial_value + difference, object.send(method)
  else
    assert_not_equal initial_value, object.send(method)
  end
end

# Assertion which checks to be sure the result of a method call on
# an object does not change while executing a block.
#
# An array of method names can be provided.  In this case, all
# methods named in the array will be checked.  If no method is provided
# and object is an instance of an ActiveRecord class, all accessible
# attributes are checked.
def assert_no_change(object, method = nil)
  if !method && object.class.respond_to?(:attr_accessible)
    method = object.class.attr_accessible
  end

  if method.kind_of?(Array)
    initial_values = {}
    method.each { |m| initial_values[m] = object.send(m) }
  else
    initial_value = object.send(method)
  end

  yield

  object.reload if object.respond_to?(:reload)

  if method.kind_of?(Array)
    method.each { |m| assert_equal initial_values[m], object.send(m) }
  else
    assert_equal initial_value, object.send(method)
  end
end
