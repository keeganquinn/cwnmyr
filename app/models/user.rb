class User < ApplicationRecord
  has_many :host_logs
  has_many :host_type_comments
  has_many :node_comments
  has_many :node_logs
  has_many :node_maintainers
  has_many :nodes, :through => :node_maintainers, :foreign_key => 'user_id'
  has_and_belongs_to_many :roles, :uniq => true
  has_many :comments, :class_name => 'UserComment'
  has_many :comments_on_others, :class_name => 'UserComment',
           :foreign_key => 'commenting_user_id'
  has_many :links, :class_name => 'UserLink'
  has_many :logs, :class_name => 'UserLog'
  has_many :zones, :through => :zone_maintainers
  has_many :zone_maintainers

  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable

  # This method returns an Array of all User instances who have either
  # given this User a positive Comment or have received a positive
  # Comment from this User.
  def friends
    friends = []

    comments.find_all_by_rating(1).each do |positive_comment|
      unless friends.include? positive_comment.commenting_user
        friends.push positive_comment.commenting_user
      end
    end

    comments_on_others.find_all_by_rating(1).each do |positive_comment|
      unless friends.include? positive_comment.user
        friends.push positive_comment.user
      end
    end

    friends
  end
end
