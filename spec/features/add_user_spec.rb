require './spec/spec_helper'

feature 'User sign up' do
  scenario 'User can visit sign up page' do
    visit '/signup'
    expect(page.status_code).to eq 200
    find_field('Username').value
    find_field('Password').value
    expect(page).to have_button('Sign up!')
  end

  scenario 'New user is created' do
    visit '/signup'
    fill_in 'Username', with: 'user@email.com'
    fill_in 'Password', with: 'Password123'
    click_button 'Sign up!'
    user = User.all
    expect(current_path).to eq '/links/navigation'
    expect(user.map(&:username)).to include('user@email.com')
    expect(user.map(&:password)).not_to be('Password123')
  end
end
