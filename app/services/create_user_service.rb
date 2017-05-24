class CreateUserService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
      user.name = Rails.application.secrets.user_name
      user.password = Rails.application.secrets.user_password
      user.password_confirmation = Rails.application.secrets.user_password
      user.confirm
    end
  end
end
