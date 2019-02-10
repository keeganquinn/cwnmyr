# frozen_string_literal: true

# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
describe 'Sign in', :devise, type: :feature do
  let(:current_user) { create(:user) }

  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  it 'user cannot sign in if not registered' do
    signin('test@example.com', 'please123')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
                                        authentication_keys: 'email'
  end

  # Scenario: User can sign in with valid credentials
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I see a success message
  it 'user can sign in with valid credentials' do
    signin(current_user.email, current_user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  # Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  it 'user cannot sign in with wrong email' do
    signin('invalid@email.com', current_user.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
                                        authentication_keys: 'email'
  end

  # Scenario: User cannot sign in with wrong password
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  it 'user cannot sign in with wrong password' do
    signin(current_user.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid',
                                        authentication_keys: 'email'
  end
end
