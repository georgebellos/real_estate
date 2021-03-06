require 'spec_helper'
include PropertySteps
include LoginSteps

feature 'Unsigned users can not create listings' do
  background do
    @user = create :user
  end
  scenario 'Unsigned users can not create a property listing' do
    visit new_property_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

feature 'Signed in users can create Listings', :vcr do
  background do
    @user = create :user
    fill_in_login_form(@user)
  end
  scenario 'creating property listings' do
    fill_in_property_form(true)
    expect{ click_button 'New Property' }.to change(Image, :count)
    expect(page).to have_content('You have created a new property')
    expect(page).to have_xpath('//img')
  end

  scenario 'Creating a property listing without an image' do
    fill_in_property_form
    expect{ click_button 'New Property' }.not_to change(Property, :count)
  end

  scenario 'Creating a property listing without valid attributes fails' do
    fill_in_property_form(true)
    fill_in 'Floor size', with: 'invalid data'
    expect{ click_button 'New Property' }.not_to change(Property, :count)
    expect(page).to have_content('Something went wrong')
  end
end

feature 'Viewing Property listings' do

  scenario 'Viewing a property listing' do
    property = create :property
    visit property_path(property)
    expect(page).to have_content('Rent Apartment')
  end

  scenario 'Viewing all property listings with pagination' do
    19.times { create :property }
    visit properties_path
    expect(page).to have_selector('div.pagination')
  end

  scenario 'Viewing a property listing found in "/properties"' do
    create :property_with_images, number_of_images: 1
    visit properties_path
    within('ul.thumbnails > li:first-child') do
      find("img[@alt='Medium_property']").click
    end
    expect(page).to have_content('Rent Apartment')
  end
end

feature 'Viewing a property listing' do
  background do
    @property = create :property
  end

  scenario 'Viewing a property listing' do
    visit property_path(@property)
    expect(page).to have_content('Rent Apartment')
  end
end

feature 'Editing Property listings', :vcr do
  background do
    @user = create :user
    fill_in_login_form(@user)
    @property = create :property, user: @user
  end

  scenario 'Editing a property listing' do
    visit property_path(@property)
    click_link 'Edit Property'
    fill_in 'Floor size', with: '200'
    click_button 'Edit Property'
    expect(page).to have_content('Property has been updated')
  end

  scenario 'Editing a property listing with invalid attributes' do
    visit property_path(@property)
    click_link 'Edit Property'
    fill_in 'Floor size', with: 'invalid data'
    click_button 'Edit Property'
    expect(page).to have_content('Something went wrong')
  end
end

feature 'Deleting Property listings' do
  background do
    @user = create :user
    fill_in_login_form(@user)
    @property = create :property, user: @user
  end

  scenario 'Deleting a property listing' do
    visit property_path(@property)
    click_link 'Delete Property'
    expect(page).to have_content('Property has been destroyed')
  end
end

feature 'Properties index multiple views' do
  background do
    @user = create :user
    create :property, status: 'Buy', category: 'Apartment',
           street: 'Kefalinias', price: 1000, bedroom: 8, floor_size: 1000,
           user: @user
  end

  scenario 'List view properties index' do
    visit properties_path
    click_link 'List'
    expect(page).to have_content("Buy")
  end

  scenario 'Thumbnails view properties index' do
    visit properties_path
    click_link 'List'
    click_link 'Thumbnails'
    expect(page).to have_content("Buy")
  end
end

feature 'Sort Properties by price' do
  background do
    @user = create :user
    create :property, status: 'Buy', category: 'Apartment',
           street: 'Kefalinias', price: 1000, bedroom: 8, floor_size: 1000,
           user: @user
    create :property, status: 'Buy', category: 'Triplex', street: 'Doiranis',
                               price: 500, bedroom: 4, floor_size: 350,
                               user: @user
    visit properties_path
  end

  scenario 'Sort properties by price in descending order' do
    click_link 'Highest first'
    within(:xpath, '//section/ul/li[1]') do
      expect(find(:xpath, './/div[@class="price-tag"]').text).to eql('1000 $')
    end
  end

  scenario 'Sort properties by price in ascending order' do
    click_link 'Lowest first'
    within(:xpath, '//section/ul/li[1]') do
      expect(find(:xpath, './/div[@class="price-tag"]').text).to eql('500 $')
    end
  end
end
