# frozen_string_literal: true

# Cinch plugin to handle user authorization requests.
class AuthRequest
  include Cinch::Plugin

  match(/auth (.+)/)

  # Do the thing.
  def execute(msg, email)
    user = User.find_by email: email
    if user
      user.unconfirmed_hostmask = "#{msg.user.user}@#{msg.user.host}"
      user.save!
    end
    msg.reply "Authorization requested for #{email}. " \
              'Please confirm in the web interface.'
  end
end
