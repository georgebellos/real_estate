require 'spec_helper'

feature 'User Registration', %q{
As an unregister user i want to create an account
In order to create property listings and favorites} do

  scenario 'Successfull Sign up with a form' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'foobar@mail.com'
    fill_in 'Password', with: 'foobar81'
    fill_in 'Password Confirmation', with: 'foobar81'
    expect { click_link_or_button 'Register your account' }.to change(User, :count)
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'Unsuccessfull Sign Up with a form' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'invalid_email.com'
    fill_in 'Password', with: 'foobar81'
    fill_in 'Password Confirmation', with: 'foobar81'
    expect{ click_link_or_button 'Register your account' }.not_to change(User, :count)
    expect(page).to have_content('Please review the problems below')
  end
end

feature 'User Sign in' do
  background { create(:user, email: 'foobar@mail.com') }

  scenario 'with valid credentials' do
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'foobar@mail.com'
    fill_in 'Password', with: 'foobar81'
    click_button 'Log in to your account'
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'with invalid credentials' do
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'foobar@mail.com'
    fill_in 'Password', with: 'wrong password'
    click_button 'Log in to your account'
    expect(page).to have_content('Invalid email or password. ')
  end
end

feature 'Signed in user' do
  background do
    create(:user, email: 'foobar@mail.com')
  end

  scenario 'Sign out' do
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'foobar@mail.com'
    fill_in 'Password', with: 'foobar81'
    click_button 'Log in to your account'
    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully.')
  end

  scenario 'Sign up' do
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'foobar@mail.com'
    fill_in 'Password', with: 'foobar81'
    click_button 'Log in to your account'
    expect(page).not_to have_content('Sign in')
    expect(page).to have_content('Sign Out')
  end
end
