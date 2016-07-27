feature 'adding a tag' do
  scenario 'I can add a tag' do
    visit 'links/new'
    fill_in 'url', with: 'www.facebook.com'
    fill_in 'title', with: 'Facebook'
    fill_in 'tags', with: 'social'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include 'social'
  end
  scenario 'I can add multiple tags' do
    visit 'links/new'
    fill_in 'url', with: 'www.facebook.com'
    fill_in 'title', with: 'Facebook'
    fill_in 'tags', with: 'social internet user'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('social', 'user', 'internet')
  end
end
