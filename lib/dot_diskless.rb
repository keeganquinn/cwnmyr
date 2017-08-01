# dot_diskless.rb
#
# Extends RGL (Ruby Graph Library) to support direct generation of graph
# images without any filesystem writes.

require 'rgl/dot'

module RGL
  # Extend the Ruby Graph Library.
  module Graph
    def to_png
      to_graphic_file('png')
    end

    def to_graphic_file(format = 'png')
      output = ''

      IO.popen("dot -T#{format}", 'r+') do |dot|
        dot.write(to_dot_graph.to_s)
        dot.close_write
        output = dot.read
      end

      output
    end
  end
end
