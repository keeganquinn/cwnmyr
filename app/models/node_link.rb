# A NodeLink instance represents a hypertext link which is related to
# a particular Node instance.
class NodeLink < ApplicationRecord
  belongs_to :node

  validates_presence_of :node_id
  validates_length_of :name, minimum: 1
  validates_length_of :url, minimum: 1
  validates_format_of :url,
    with: %r{https?://([-\w\.]+)+(:\d+)?(/([\w/_\.]*(\?\S+)?)?)?},
    message: 'must be a valid HTTP URI.',
    if: Proc.new { |o| o.url and o.url.size > 1 }
end
