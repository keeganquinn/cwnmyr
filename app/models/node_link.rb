# A NodeLink instance represents a hypertext link which is related to
# a particular Node instance.
class NodeLink < ApplicationRecord
  belongs_to :node

  validates_length_of :name, minimum: 1
  validates_length_of :url, minimum: 1
  validates_format_of :url,
                      with: %r{https?://([-\w\.]+)+(:\d+)?
                            (/([\w/_\.]*(\?\S+)?)?)?}x,
                      message: 'must be a valid HTTP URI.',
                      if: proc { |o| o.url && o.url.size > 1 }

  def to_param
    return unless id
    [id, name.parameterize].join('-')
  end
end
