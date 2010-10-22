# dot_diskless.rb
#
# $Id: dot_diskless.rb 2629 2006-05-19 21:03:53Z keegan $
#
# Extends RGL (Ruby Graph Library) to support direct generation of graph
# images without any filesystem writes.

require 'rgl/dot'

module RGL
  module Graph

    def to_jpg
      to_graphic_file('jpg')
    end

    def to_png
      to_graphic_file('png')
    end

    def to_graphic_file(format = 'png')
      output = ''

      IO.popen("dot -T#{format}", 'r+') do |dot|
        dot.write(to_dot_graph_custom.to_s)
        dot.close_write
        output = dot.read
      end

      output
    end

    def to_dot_graph_custom
      params = {
        'name' => '',
        'fontsize' => '8'
      }

      graph      = DOT::DOTSubgraph.new(params)

      each_vertex do |v|
        name = v.to_s

        fontsize = 10
        color = 'black'
        shape = 'box'
        if name =~ %r{.*: .*}
          fontsize = 8
          color = 'blue'
          shape = 'ellipse'
        end

        graph << DOT::DOTNode.new('name'     => '"' + name + '"',
                                  'fontsize' => fontsize,
                                  'color'    => color,
                                  'shape'    => shape,
                                  'label'    => name)
      end

      each_edge do |u,v|
        graph << DOT::DOTEdge.new('from'     => '"'+ u.to_s + '"',
                                  'to'       => '"'+ v.to_s + '"',
                                  'fontsize' => 8)
      end

      graph
    end

  end
end
