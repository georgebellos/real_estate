require 'spec_helper'
include PropertySteps

feature 'Property', :vcr do
  scenario 'Successfull creation via form' do
    fill_in_property_form(true)
    expect{ click_button 'New Property' }.to change(Image, :count)
    expect(page).to have_content('You have created a new property')
    expect(page).to have_xpath('//img')
  end

  scenario 'Successfull creation via form without an image' do
    fill_in_property_form
    expect{ click_button 'New Property' }.to change(Property, :count)
    expect(page).to have_content('You have created a new property')
  end

  scenario 'Unsuccessfull creation via form' do
    fill_in_property_form(true)
    fill_in 'Floor size', with: 'invalid data'
    expect{ click_button 'New Property' }.not_to change(Property, :count)
    expect(page).to have_content('Something went wrong')
  end
end
