# frozen_string_literal: true

describe AuthConfirm do
  subject(:concern) { described_class.new bot }

  let(:bot) { CinchBotService.new.bot }
  let(:msg) { Cinch::Message.new nil, bot }

  it 'can confirm authorization' do
    msg.stub :reply
    concern.execute msg
    expect(msg).to have_received :reply
  end
end
