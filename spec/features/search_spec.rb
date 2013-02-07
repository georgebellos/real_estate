require 'spec_helper'
require 'pry'

feature 'Search', :elasticsearch do
  background do
    Property.tire.index.delete
    Property.tire.index.create
    create :property, status: 'Buy', category: 'Triplex', street: 'Doiranis',
                               price: 500, bedroom: 4, floor_size: 350
    create :property, status: 'Rent', category: 'Apartment', street: 'Kefalinias',
                               price: 1000, bedroom: 8, floor_size: 1000
    Property.tire.index.refresh
    visit properties_path
  end

  scenario 'quick search' do
    fill_in 'search[query]', with: 'Buy Triplex'
    click_button 'Quick Search'
    expect(page).to have_content('Doiranis')
    expect(page).not_to have_content('Kefalinias')
    expect(page).to have_content('Found 1 property listings with this search criteria')
  end

  scenario 'no property listings found' do
    fill_in 'search[query]', with: 'not listed'
    click_button 'Quick Search'
    expect(page).to have_content('No property listings were found with this search criteria')
  end
end
