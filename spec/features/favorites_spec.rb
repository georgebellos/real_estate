require 'spec_helper'
include LoginSteps

feature 'Favorite property listings' do
  background do
    @user = create :user
    fill_in_login_form(@user)
    @property = create :property, user: @user
    @other_property = create :property
  end

  scenario 'Mark a property listing as favorite' do
    visit property_path(@other_property)
    click_link 'Marks as favorite'
    expect(page).to have_content('You favorited Apartment at Doiranis')
  end

  scenario 'Remove a property from favorites' do
    visit property_path(@other_property)
    click_link 'Marks as favorite'
    visit property_path(@other_property)
    click_link 'Remove from favorites'
    expect(page).to have_content('You unfavorited Apartment at Doiranis')
  end

  scenario 'A user can not mark as favorite his own listings' do
    visit property_path(@property)
    expect(page).not_to have_content('Mark as favorite')
  end

  scenario 'A user can see what listings has favorite' do
    visit property_path(@other_property)
    click_link 'Marks as favorite'
    expect(page).to have_content('Rent Apartment')
  end
end
