require './spec/spec_helper'
require 'timecop'

feature 'Reset password' do
  before do
    sign_up
    Capybara.reset!
  end

  let(:user) { User.first }

  scenario 'When I enter my email I am told to check my inbox' do
    recover_password
    expect(page).to have_content "Thanks, Please check your inbox for the link."
  end

   scenario 'assigned a reset token to the user when they recover' do
     sign_up
     expect{recover_password}.to change{User.first.password_token}
   end

   def recover_password
     visit '/users/recover'
     fill_in :email, with: "alice@example.com"
     click_button "Submit"
   end

  scenario 'it doesn\'t allow you to use the token after an hour' do
    recover_password
    Timecop.travel(60 * 60 * 60) do
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content "Your token is invalid"
    end
  end

  scenario 'it asks for your new password when your token is valid' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content("Please enter your new password")
  end

  scenario 'When I forget my password I can see a link to reset' do
    visit '/sessions/new'
    click_link 'I forgot my password'
    expect(page).to have_content("Please enter your email address")
  end


end
