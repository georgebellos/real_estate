require 'spec_helper'
include PropertySteps

feature 'Creating Properties Listings', :vcr do
  scenario 'Creating a property listing' do
    fill_in_property_form(true)
    expect{ click_button 'New Property' }.to change(Image, :count)
    expect(page).to have_content('You have created a new property')
    expect(page).to have_xpath('//img')
  end

  scenario 'Creating a property listing without an image' do
    fill_in_property_form
    expect{ click_button 'New Property' }.to change(Property, :count)
    expect(page).to have_content('You have created a new property')
  end

  scenario 'Creating a property listing without valid attributes fails' do
    fill_in_property_form(true)
    fill_in 'Floor size', with: 'invalid data'
    expect{ click_button 'New Property' }.not_to change(Property, :count)
    expect(page).to have_content('Something went wrong')
  end
end

feature 'Viewing Property listings' do
  background do
    @user = create :user
    @property = create :property_with_images
    13.times { create :property, user: @user }
  end

  scenario 'Viewing a property listing' do
    visit property_path(@property)
    expect(page).to have_content('Rent Apartment')
    expect(page).to have_selector('.img-polaroid')
  end

  scenario 'Viewing all property listings with pagination' do
    visit properties_path
    expect(page).to have_selector('div.pagination')
  end

  scenario 'Viewing a property listing found in "/properties"' do
    visit properties_path
    within('ul.thumbnails > li:first-child') do
      click_link('Info')
    end
    expect(page).to have_content('Rent Apartment')
  end
end
