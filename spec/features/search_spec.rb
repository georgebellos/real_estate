require 'spec_helper'
require 'pry'

feature 'Search', :elasticsearch do
  background do
    Property.tire.index.delete
    Property.tire.index.create
    @user = create :user
    create :property, status: 'Buy', category: 'Triplex', street: 'Doiranis',
                               price: 500, bedroom: 4, floor_size: 350,
                               user: @user
    create :property, status: 'Rent', category: 'Apartment',
           street: 'Kefalinias', price: 1000, bedroom: 8, floor_size: 1000,
           user: @user
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

  scenario 'Filter properties by type' do
    find(:xpath, "//input[@value='Triplex']").set(true)
    click_button 'Quick Search'
    expect(page).to have_content('Doiranis')
    expect(page).not_to have_content('Kefalinias')
  end

  scenario 'Filter properties by price' do
    fill_in 'search[price_from]', with: 0
    fill_in 'search[price_to]', with: 600
    click_button 'Quick Search'
    expect(page).to have_content('Doiranis')
    expect(page).not_to have_content('Kefalinias')
  end

  scenario 'Filter properties by bedrooms' do
    fill_in 'search[bedrooms_from]', with: 0
    fill_in 'search[bedrooms_to]', with: 5
    click_button 'Quick Search'
    expect(page).to have_content('Doiranis')
    expect(page).not_to have_content('Kefalinias')
  end

  scenario 'Filter properties by floor size' do
    fill_in 'search[floor_size_from]', with: 0
    fill_in 'search[floor_size_to]', with: 400
    click_button 'Quick Search'
    expect(page).to have_content('Doiranis')
    expect(page).not_to have_content('Kefalinias')
  end

end

feature 'Sort Search Results', :elasticsearch do
  background do
    Property.tire.index.delete
    Property.tire.index.create
    @user = create :user
    create :property, status: 'Buy', category: 'Apartment',
           street: 'Kefalinias', price: 1000, bedroom: 8, floor_size: 1000,
           user: @user
    create :property, status: 'Buy', category: 'Triplex', street: 'Doiranis',
                               price: 500, bedroom: 4, floor_size: 350,
                               user: @user
    Property.tire.index.refresh
    visit properties_path
  end

  scenario 'Sort search results by price in descending order' do
    fill_in 'search[query]', with: 'Buy'
    click_button 'Quick Search'
    click_link 'Highest first'
    within(:xpath, '//section/ul/li[1]') do
      expect(find(:xpath, './/div[@class="price-tag"]').text).to eql('1000 $')
    end
  end

  scenario 'Sort search results by price in ascending order' do
    fill_in 'search[query]', with: 'Buy'
    click_button 'Quick Search'
    click_link 'Lowest first'
    within(:xpath, '//section/ul/li[1]') do
      expect(find(:xpath, './/div[@class="price-tag"]').text).to eql('500 $')
    end
  end
end
