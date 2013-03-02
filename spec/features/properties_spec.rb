require 'spec_helper'
include PropertySteps

feature 'Unsigned users can not create listings' do
  background do
    @user = create :user
  end
  scenario 'Unsigned users can not create a property listing' do
    visit new_property_path
    expect(page).to have_content('Please sign in')
  end
end

feature 'Signed in users can create Listings', :vcr do
  background do
    @user = create :user
  end
  scenario 'creating property listings' do
    page.set_rack_session(user_id: @user.id)
    fill_in_property_form(true)
    expect{ click_button 'New Property' }.to change(Image, :count)
    expect(page).to have_content('You have created a new property')
    expect(page).to have_xpath('//img')
  end

  scenario 'Creating a property listing without an image' do
    page.set_rack_session(user_id: @user.id)
    fill_in_property_form
    expect{ click_button 'New Property' }.to change(Property, :count)
    expect(page).to have_content('You have created a new property')
  end

  scenario 'Creating a property listing without valid attributes fails' do
    page.set_rack_session(user_id: @user.id)
    fill_in_property_form(true)
    fill_in 'Floor size', with: 'invalid data'
    expect{ click_button 'New Property' }.not_to change(Property, :count)
    expect(page).to have_content('Something went wrong')
  end
end

feature 'Viewing Property listings' do
  background do
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
      find("img[@alt='Medium_property']").click
    end
    expect(page).to have_content('Rent Apartment')
  end
end

feature 'Editing Property listings', :vcr do
  background do
    @user = create :user
    @property = create :property, user: @user
  end

  scenario 'Editing a property listing' do
    page.set_rack_session(user_id: @user.id)
    visit property_path(@property)
    click_link 'Edit Property'
    fill_in 'Floor size', with: '200'
    click_button 'Edit Property'
    expect(page).to have_content('Property has been updated')
  end

  scenario 'Editing a property listing with invalid attributes' do
    page.set_rack_session(user_id: @user.id)
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
    @property = create :property, user: @user
  end

  scenario 'Deleting a property listing' do
    page.set_rack_session(user_id: @user.id)
    visit property_path(@property)
    click_link 'Delete Property'
    expect(page).to have_content('Property has been destroyed')
  end
end

feature 'Favorite property listings' do
  background do
    @user = create :user
    @property = create :property, user: @user
    @other_property = create :property
  end

  scenario 'Mark a property listing as favorite' do
    page.set_rack_session(user_id: @user.id)
    visit property_path(@other_property)
    click_link 'Marks as favorite'
    expect(page).to have_content('You favorited Apartment at Doiranis')
  end

  scenario 'Mark a property listing as unfavorite' do
    page.set_rack_session(user_id: @user.id)
    visit property_path(@other_property)
    click_link 'Marks as favorite'
    visit property_path(@other_property)
    click_link 'Marks as unfavorite'
    expect(page).to have_content('You unfavorited Apartment at Doiranis')
  end

  scenario 'A user can not mark as favorite his own listings' do
    visit property_path(@property)
    expect(page).not_to have_content('Mark as favorite')
  end

  scenario 'A user can see what listings has favorite' do
    page.set_rack_session(user_id: @user.id)
    visit property_path(@other_property)
    click_link 'Marks as favorite'
    expect(page).to have_content('Rent Apartment')
  end
end
