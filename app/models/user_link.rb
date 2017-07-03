# A UserLink instance represents a hypertext link which is related to
# a particular User instance.
class UserLink < ApplicationRecord
  belongs_to :user

  validates_length_of :name, minimum: 1
  validates_length_of :url, minimum: 1
  validates_format_of :url,
    with: %r{https?://([-\w\.]+)+(:\d+)?(/([\w/_\.]*(\?\S+)?)?)?},
    message: 'must be a valid HTTP URI.',
    if: Proc.new { |o| o.url and o.url.size > 1 }

  def to_param
    return nil if not id
    [id, name.parameterize].join('-')
  end
end
