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
