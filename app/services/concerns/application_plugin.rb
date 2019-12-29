# frozen_string_literal: true

# This class is parent to all Cinch plugins in the application.
class ApplicationPlugin
  attr_reader :msg

  # Determine the hostmask of the current command.
  def hostmask
    "#{msg.user.user}@#{msg.user.host}"
  end

  # Locate the current authorized User.
  def current_user
    User.find_by hostmask: hostmask
  end

  # Handle a matched request.
  def execute(message)
    @msg = message
    respond
  end
end
