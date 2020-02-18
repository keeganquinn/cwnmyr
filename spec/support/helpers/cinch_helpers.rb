# frozen_string_literal: true

module Features
  # Helper methods for convenience use in tests.
  module CinchHelpers
    # Create a CinchBotService instance for testing.
    def cinch_bot
      bot = CinchBotService.new.bot
      irc = Cinch::IRC.new bot
      irc.setup
      allow(bot).to receive(:irc).and_return(irc)
      bot
    end

    # Create an Authorization and User for testing.
    def cinch_user
      create(:authorization, provider: 'cinch', uid: 'test@test.com').user
    end

    # Construct a Cinch::Message.
    def cinch_msg(bot, user, txt)
      auth = user.authorizations.find_by provider: 'cinch'
      msg = Cinch::Message.new ":test!#{auth.uid} PRIVMSG #t :#{txt}", bot
      msg.stub :reply
      msg
    end
  end
end
