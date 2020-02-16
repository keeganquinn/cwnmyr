# frozen_string_literal: true

describe AuthRequest do
  subject(:concern) { described_class.new bot }

  let(:bot) { CinchBotService.new.bot }
  let(:msg) { Cinch::Message.new nil, bot }

  it 'can request authorization' do
    msg.stub :reply
    concern.execute msg, 'test@test.com'
    expect(msg).to have_received :reply
  end
end
