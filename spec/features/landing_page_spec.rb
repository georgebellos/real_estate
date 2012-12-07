require 'spec_helper'

feature 'Home Page', %q{
  As an unregistered user
  I want to find information about the apllication
} do
  background { visit root_path }
  scenario "Application About information" do
    click_link 'About'
    expect(page).to have_content('About Real Estate')
  end

  scenario "Application Contact Information" do
    click_link 'Contact'
    expect(page).to have_content('Contact')
  end

  scenario "Application Sign Up information" do
    expect(page).to have_content('Sign Up')
  end
end
