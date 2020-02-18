# frozen_string_literal: true

# Cinch plugin to handle user authorization confirmation.
class AuthConfirm < ApplicationPlugin
  include Cinch::Plugin

  match(/confirm/)

  # Do the thing.
  def respond
    if current_user
      reply "You have confirmed authorization for #{hostmask}."
    else
      reply "No authorization found for #{hostmask}."
    end
  end
end
