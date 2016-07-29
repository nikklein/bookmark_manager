require './spec/spec_helper'


feature 'User sign in' do

  let!(:user) do
    User.create(email: 'user@example.com',
                password: 'secret1234',
                password_confirmation: 'secret1234')
  end


  scenario 'with correct credentials' do
    sign_in(email: user.email,   password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end

  def sign_in(email:, password:)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end

end

# feature 'Resetting Password' do
#
#  scenario 'When I forget my password I can see a link to reset' do
#    visit '/sessions/new'
#    click_link 'I forgot my password'
#    expect(page).to have_content("Please enter your email address")
#  end
#  scenario 'When I enter my email I am told to check my inbox' do
#    recover_password
#    expect(page).to have_content "Thanks, Please check your inbox for the link."
#  end
#
#   scenario 'assigned a reset token to the user when they recover' do
#     sign_up
#     expect{recover_password}.to change{User.first.password_token}
#   end
#
#   def recover_password
#     visit '/users/recover'
#     fill_in :email, with: "alice@example.com"
#     click_button "Submit"
#   end
#
#
# end
