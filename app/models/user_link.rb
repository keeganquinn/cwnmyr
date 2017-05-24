# A UserLink instance represents a hypertext link which is related to
# a particular User instance.
class UserLink < ApplicationRecord
  default_scope { order('user_id, name ASC') }

  belongs_to :user

  validates_presence_of :user_id
  validates_length_of :name, :minimum => 1
  validates_length_of :url, :minimum => 1
  validates_format_of :url,
    :with => %r{https?://([-\w\.]+)+(:\d+)?(/([\w/_\.]*(\?\S+)?)?)?},
    :message => 'must be a valid HTTP URI.',
    :if => Proc.new { |o| o.url and o.url.size > 1 }

  def to_param
    [id, name.parameterize].join('-')
  end
end
