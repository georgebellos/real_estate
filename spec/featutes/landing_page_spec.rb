require 'spec_helper'

feature 'A User visits the Home Page' do
  scenario "Finds 'About and Contact' information for the application" do
    visit root_path
    click_link 'About'
    expect(page).to have_content('About')
    visit root_path
    click_link 'Contact'
    expect(page).to have_content('Contact')
  end
end
