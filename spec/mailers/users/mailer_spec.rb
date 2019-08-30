# frozen_string_literal: true

describe Users::Mailer, type: :mailer do
  let(:user) { build_stubbed :user }

  describe 'confirmation_instructions' do
    let(:mail) { Users::Mailer.confirmation_instructions(user, 'abc') }

    it { expect(mail.subject).to match(/(.*)?: Confirmation Instructions/) }
  end

  describe 'reset_password_instructions' do
    let(:mail) { Users::Mailer.reset_password_instructions(user, 'abc') }

    it { expect(mail.subject).to match(/(.*)?: Reset Password Instructions/) }
  end

  describe 'unlock_instructions' do
    let(:mail) { Users::Mailer.unlock_instructions(user, 'abc') }

    it { expect(mail.subject).to match(/(.*)?: Unlock Instructions/) }
  end

  describe 'email_changed' do
    let(:mail) { Users::Mailer.email_changed(user) }

    it { expect(mail.subject).to match(/(.*)?: Email Changed/) }
  end

  describe 'password_change' do
    let(:mail) { Users::Mailer.password_change(user) }

    it { expect(mail.subject).to match(/(.*)?: Password Change/) }
  end
end
