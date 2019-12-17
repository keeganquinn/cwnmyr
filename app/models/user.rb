# frozen_string_literal: true

# A User is a person who can log in to the system.
class User < ApplicationRecord
  has_paper_trail

  has_and_belongs_to_many :groups, uniq: true
  has_many :contacts
  has_many :nodes
  has_many :notable_requests, class_name: 'Notable::Request'
  has_many :visits, class_name: 'Ahoy::Visit'

  enum role: %i[user manager admin]

  validates_length_of :code, maximum: 64
  validates_uniqueness_of :code, allow_blank: true, case_sensitive: false
  validates_format_of :code,
                      with: /\A[-_a-zA-Z0-9]+\z/,
                      message: 'contains unacceptable characters',
                      allow_blank: true
  validates_uniqueness_of :name, allow_blank: true, case_sensitive: false
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email,
                      with: /\A([\w\+\-\.\#\$%&!?*\'=(){}|~_]+)
                            @([0-9a-zA-Z\-\.\#\$%&!?*\'=(){}|~]+)+\z/x,
                      message: 'must be a valid email address',
                      allow_blank: true

  before_validation :set_defaults

  scope :visible, lambda {
    where(["spam IS NULL AND code IS NOT NULL AND code != ''"])
  }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable, :omniauthable, :lockable,
         omniauth_providers: Devise.active_providers
  mailkick_user

  # Locate a User from a provided set of OmniAuth credentials.
  def self.from_omniauth(auth)
    return unless auth&.info&.email

    where(email: auth.info.email).first_or_create do |user|
      user.password ||= Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  # Canonical identifier.
  def to_param
    return unless id

    code && [id, code].join('-') || id.to_s
  end

  # Set default values.
  def set_defaults
    self.code = name.parameterize if name
    self.role ||= :user
  end

  # Return true if the user has a visible profile.
  def visible?
    !code.blank? && !spam
  end
end
