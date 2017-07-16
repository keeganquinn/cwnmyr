# Service to create a default non-privileged user.
class CreateUserService
  USER_ATTRS = {
    name: Rails.application.secrets.user_name,
    password: Rails.application.secrets.user_password,
    password_confirmation: Rails.application.secrets.user_password
  }.freeze

  def call
    User.find_or_create_by! email: Rails.application.secrets.user_email do |u|
      u.assign_attributes USER_ATTRS
      u.confirm
    end
  end
end
