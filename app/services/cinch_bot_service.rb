# frozen_string_literal: true

# Service to provide a Cinch IRC bot.
class CinchBotService
  CINCH_CONFIG = {
    server: ENV['IRC_SERVER'] || 'xmit.quinn.tk',
    port: ENV['IRC_PORT']&.to_i || 6697,
    user: ENV['IRC_USER'] || 'cwnmyr',
    realname: ENV['IRC_NAME'] || 'cwnmyr | https://github.com/keeganquinn/cwnmyr',
    nick: ENV['IRC_NICK'] || "cwnmyr_#{Socket.gethostname.split('.').first}",
    channels: ENV['IRC_CHANNEL'].blank? ? ['#devbots'] : [ENV['IRC_CHANNEL']]
  }.freeze

  CINCH_PLUGINS = [AuthConfirm, AuthRequest].freeze

  # Start the bot.
  def call
    bot.start
  end

  # Initialize a Cinch bot instance.
  def bot
    @bot ||= Cinch::Bot.new do
      configure do |c|
        CINCH_CONFIG.each { |k, v| c.send "#{k}=", v }
        c.ssl.use = ENV['IRC_SSL'].blank? ? true : ENV['IRC_SSL'] == '1'
        c.plugins.plugins = CINCH_PLUGINS
        c.plugins.prefix = ENV['IRC_PREFIX'] || '@'
      end
    end
  end
end
