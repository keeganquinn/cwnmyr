# A UserLink instance represents a hypertext link which is related to
# a particular User instance.
class UserLink < ApplicationRecord
  has_paper_trail
  belongs_to :user

  validates_length_of :name, minimum: 1
  validates_length_of :url, minimum: 1
  validates_format_of :url,
                      with: %r{\Ahttps?://([-\w\.]+)+(:\d+)?
                            (/([\w/_\.]*(\?\S+)?)?)?\z}x,
                      message: 'must be a valid HTTP URI.',
                      allow_blank: true

  def to_param
    return unless id
    [id, name.parameterize].join('-')
  end
end
