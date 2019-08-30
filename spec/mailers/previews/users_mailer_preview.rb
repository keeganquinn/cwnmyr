# frozen_string_literal: true

module Users
  # ActionMailer preview class for UserMailer.
  class MailerPreview < ActionMailer::Preview
    def confirmation_instructions
      Users::Mailer.confirmation_instructions(User.first, {})
    end

    def email_changed
      Users::Mailer.email_changed(User.first, {})
    end

    def password_change
      Users::Mailer.password_change(User.first, {})
    end

    def reset_password_instructions
      Users::Mailer.reset_password_instructions(User.first, {})
    end

    def unlock_instructions
      Users::Mailer.unlock_instructions(User.first, {})
    end
  end
end
