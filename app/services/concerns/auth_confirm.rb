# frozen_string_literal: true

# Cinch plugin to handle user authorization confirmation.
class AuthConfirm < ApplicationPlugin
  include Cinch::Plugin

  match(/confirm/)

  # Do the thing.
  def respond
    if current_user
      msg.reply "Hello #{msg.user.nick}, " \
                "you have confirmed authorization for #{hostmask}."
    else
      msg.reply "No authorization found for #{hostmask}."
    end
  end
end
