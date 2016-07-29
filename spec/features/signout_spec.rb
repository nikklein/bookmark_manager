require './spec/spec_helper'
require './spec/web_helper'

feature 'User sign out' do
  scenario 'I can sign out' do
    sign_up
    sign_in(email: 'user@email.com', password: 'Password123')
    sign_out
    expect(current_path).to eq('/signout')
    expect(page).to have_content "Goodbye!"
  end
end
