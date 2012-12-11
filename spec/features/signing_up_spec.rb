require 'spec_helper'

feature 'User Registration', %q{
  As an unregister user i want to create an account
  In order to create property listings and favorites} do
  scenario "Successfull Sign up with a form" do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'foobar@mail.com'
    all(:field,'Password').each{|field| field.set('foobar') }
    expect { click_button 'Create Account'}.to change(User, :count)
    expect(page).to have_content('You have signed up successfully')
  end
  scenario "Unsuccessfull Sign Up with a form" do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'invalid_email.com'
    all(:field,'Password').each{|field| field.set('foobar') }
    expect{ click_button 'Create Account' }.not_to change(User, :count)
    expect(page).to have_content('Something went wrong')
  end
end
