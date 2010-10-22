#--
# $Id: application_helper.rb 849 2009-10-24 01:31:26Z keegan $
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

# Methods added to this helper will be available to all templates in
# the application.
module ApplicationHelper
  # Convenience method to access the configured application name.
  def app_name
    t :cwnmyr
  end

  # Generate a series of links based on the path of the current request.
  def links_from_path
    full_path, action = request.path.gsub(/\A\//, '').split(';')

    return '' if @hide_nav or full_path.nil?

    output = link_to_unless_current(app_name, welcome_path)
    this_path = ''

    full_path.split('/').each_slice(2) do |name, key|
      this_path << "/#{name}"
      output << ' &rarr; '
      output << link_to_unless_current(t(name), this_path)

      if key and key != 'show' and key != 'map'
        this_path << "/#{key}"
        output << ' &rarr; '
        output << link_to_unless_current(key, this_path)
      end
    end

    if action
      output << ' &rarr; '
      output << t(action)
    end

    output
  end

  # Shortcut to generate link tags for RSS, RDF, etc.
  def meta_link(type, path, title, rel = 'alternate')
    auto_discovery_link_tag type, path, { :title => title, :rel => rel }
  end

  # A version of options_from_collection_for_select with default values for
  # value_method and text_method, suitable for handling collections of
  # ActiveRecord instances.
  def option_tags_from_records(*args)
    collection = args.shift
    value = args.shift || :to_param
    text = args.shift || :name
    selected = args.shift

    options_from_collection_for_select collection, value, text, selected
  end

  # Returns the text with all the Textile codes turned into HTML-tags.
  #
  # This implementation should supersede the one included with Rails in
  # ActionView::Helpers::TextHelper; as of Rails 2.0.1, the provided
  # implementation produces incorrect output.
  #
  # See http://wiki.rubyonrails.org/rails/pages/RedCloth.
  def textilize(text)
    text.nil? ? nil : RedCloth.new(text).to_html
  end
end
