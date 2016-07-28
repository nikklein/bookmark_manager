feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect{sign_up}.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires password confirmation' do
    expect { sign_up(password_confirmation: 'incorrect') }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    expect {sign_up(password_confirmation: 'incorrect')}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation do not match'
  end

  def sign_up(email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

  scenario "I can't sign up without an email address" do
    expect { sign_up(email: nil) }.not_to change(User, :count)
  end

  scenario "I can't sign up without valid email address" do
    expect { sign_up(email: "notvalid@google") }.not_to change(User, :count)
  end

end
