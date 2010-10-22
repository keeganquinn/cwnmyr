#--
# $Id: zones_helper.rb 463 2007-07-08 15:29:10Z keegan $
# Copyright 2007 Keegan Quinn
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

module ZonesHelper
  def zone_map
    markers = []
    @zone.nodes.each do |node|
      if point = node.average_point
        markers << GMarker.new([point[:latitude], point[:longitude]],
                               :title => node.name,
                               :info_window => "<a href=\"" +
                                  url_for(:controller => 'node',
                                          :action => 'show',
                                          :code => node.code) + "\">" +
                                  node.name + "</a>")
      end
    end

    unless markers.empty?
      @map = GMap.new('zone_map')
      @map.overlay_init Clusterer.new(markers)
      @map.center_zoom_init markers.first.point, 12
      return @map.div(:width => 320, :height => 240)
    end
  end
end
