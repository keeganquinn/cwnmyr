# Service to create a default administrator user.
class CreateAdminService
  ADMIN_ATTRS = {
    name: Rails.application.secrets.admin_name,
    password: Rails.application.secrets.admin_password,
    password_confirmation: Rails.application.secrets.admin_password
  }.freeze

  def call
    User.find_or_create_by! email: Rails.application.secrets.admin_email do |u|
      u.assign_attributes ADMIN_ATTRS
      u.confirm
      u.admin!
    end
  end
end
