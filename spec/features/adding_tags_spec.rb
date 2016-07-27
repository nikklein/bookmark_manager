feature 'adding a tag' do
  scenario 'I can add a tag' do
    visit 'links/new'
    fill_in 'url', with: 'www.facebook.com'
    fill_in 'title', with: 'Facebook'
    fill_in 'tag', with: 'social'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include 'social'
  end
end
