# frozen_string_literal: true

# Cinch plugin to handle user authorization requests.
class AuthRequest < ApplicationPlugin
  include Cinch::Plugin

  match(/auth (.+)/)

  # Do the thing.
  def respond(email)
    return reply('You are already authorized.') if current_user

    if hostmask
      user = User.find_by email: email
      user&.authorizations&.create! provider: 'cinch', uid: hostmask
    end

    reply "Authorization requested for #{email}. " \
          'Please confirm in the web interface.'
  end
end
