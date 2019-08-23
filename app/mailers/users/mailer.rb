# frozen_string_literal: true

module Users
  # Customize Devise mailer.
  class Mailer < Devise::Mailer
    helper :application
    include Devise::Controllers::UrlHelpers
    layout 'mailer'

    def confirmation_instructions(record, token, opts = {})
      opts[:subject] = "#{default_title}: #{t(:confirmation_instructions)}"
      super
    end

    def reset_password_instructions(record, token, opts = {})
      opts[:subject] = "#{default_title}: #{t(:reset_password_instructions)}"
      super
    end

    def unlock_instructions(record, token, opts = {})
      opts[:subject] = "#{default_title}: #{t(:unlock_instructions)}"
      super
    end

    def email_changed(record, opts = {})
      opts[:subject] = "#{default_title}: #{t(:email_changed)}"
      super
    end

    def password_change(record, opts = {})
      opts[:subject] = "#{default_title}: #{t(:password_change)}"
      super
    end

    private

    def default_title
      Zone.default&.title || t(:cwnmyr)
    end
  end
end
