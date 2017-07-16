xml.instruct!

xml << render(partial: 'node_links/node_link.xml',
              locals: { node_link: @node_link })
