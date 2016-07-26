feature 'creating links' do

  scenario 'I can create a new link' do
    visit 'links/new'
    fill_in 'url', with: 'http://yahoo.com'
    fill_in 'title', with: 'Yahoo'
    click_button 'Create link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
    expect(page).to have_content('Yahoo')
  end
end
end
