require 'spec_helper'

feature 'Home Page', %q{
  As an unregistered user
  I want to find information about the apllication
} do
  scenario "Application About information" do
    visit root_path
    click_link 'About'
    expect(page).to have_content('About Real Estate')
  end
  scenario "Application Contact Information" do
    visit root_path
    click_link 'Contact'
    expect(page).to have_content('Contact')
  end
end
