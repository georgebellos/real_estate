require 'spec_helper'

feature 'Latest entries', %q{
  As an unregistered user
  When i go to the landing page
  I want to see the last 8 properties entries
} do
  background do
    9.times {create :property }
  end

  scenario '8 latest properties entries' do
    visit root_path
    expect(page).to have_selector('.thumbnail', count: 8)
  end
end

feature 'Search Entries',  %q{
  As an unregistered user
  When i go to the landing page
  I want to be able to search for properties
}, :elasticsearch  do
  background do
    Property.tire.index.delete
    Property.tire.index.create
    @user = create :user
    create :property, status: 'Buy', category: 'Triplex', street: 'Doiranis',
                               price: 500, bedroom: 4, floor_size: 350
    Property.tire.index.refresh
  end

  scenario 'Search properties from landing page' do
    visit root_path
    fill_in 'search[query]', with: 'Buy Triplex'
    click_button 'Quick Search'
    expect(page).to have_content('Doiranis')
    expect(page).not_to have_content('Kefalinias')
    expect(page).to have_content('Found 1 property listings with this search criteria')
  end
end

feature 'Featured Properties', %q{
  As an unregistered user
  When i go to the landing page
  I want to see the last 3 properties entries in a carusel
} do
  background do
    3.times { create :property }
  end
  scenario 'Featured Properties' do
    visit root_path
    expect(page).to have_selector(".carousel-caption", count: 3)
  end
end
