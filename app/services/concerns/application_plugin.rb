# frozen_string_literal: true

# This class is parent to all Cinch plugins in the application.
class ApplicationPlugin
  attr_reader :msg

  # Command prefix.
  def prefix
    ENV['IRC_PREFIX'] || '@'
  end

  # Determine the hostmask of the current command.
  def hostmask
    "#{msg.user.user}@#{msg.user.host}" if msg&.user
  end

  # Locate the current authorized User.
  def current_user
    return unless hostmask

    Authorization.confirmed.find_by(provider: 'cinch', uid: hostmask)&.user
  end

  # Handle a matched request.
  def execute(message, *args)
    @msg = message
    respond(*args)
  end

  # Handle a listener request.
  def listen(message)
    execute message
  end

  # Send a directed response.
  def reply(txt)
    msg.reply msg&.user&.nick ? "#{msg.user.nick}: #{txt}" : txt
  end

  # Send a response to unauthorized requests.
  def not_authorized
    reply "You are not authorized. Try #{prefix}auth <email>"
  end
end
