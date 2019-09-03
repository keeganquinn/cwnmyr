# frozen_string_literal: true

module Users
  # OmniAuth controller for Devise.
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      request_for 'Facebook'
    end

    def google_oauth2
      request_for 'Google'
    end

    protected

    def request_for(provider)
      auth = request.env['omniauth.auth']
      @authorization = authorization(auth)

      if @authorization.user&.persisted?
        do_sign_in @authorization.user, provider
      else
        session["devise.#{provider.downcase}_data"] = auth
        redirect_to new_user_registration_url
      end
    end

    def authorization(auth)
      @authorization = Authorization.from_omniauth(auth)

      if signed_in?
        @authorization.user = current_user
        @authorization.save
      end

      if @authorization.user.blank?
        @authorization.user = User.from_omniauth(auth)
        @authorization.save
      end

      @authorization
    end

    def do_sign_in(user, kind)
      sign_in_and_redirect user, event: :authentication
      set_flash_message :notice, :success, kind: kind if is_navigational_format?
    end
  end
end
