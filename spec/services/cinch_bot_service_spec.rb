# frozen_string_literal: true

describe CinchBotService do
  subject(:service) { described_class }

  let(:bot) { service.new }

  before do
    bot.bot.configure do |c|
      c.nick = "cwnmyr_test_#{SecureRandom.hex[0..7]}"
    end

    bot.bot.on :connect do
      bot.bot.quit
    end
  end

  it 'creates a bot' do
    expect { bot.call }.not_to raise_exception
  end
end
