feature 'Adding tags' do

  before :each do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
  end

  scenario 'I can add a tag to a new link' do
    fill_in 'tags', with: 'education'
    click_button 'Add link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

  scenario 'I can add multiple tags to a new link' do
    fill_in 'tags', with: 'education ruby'
    click_button 'Add link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

end
