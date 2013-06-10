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

feature 'Latest entries', %q{
  As an unregistered user
  When i go to the landing page
  I want to see the last 8 properties entries
} do
  background do
    9.times {create :property }
  end

  scenario '8 latest properties entries' do
    visit root_path
    expect(page).to have_selector('.thumbnail', count: 8)
  end
end
