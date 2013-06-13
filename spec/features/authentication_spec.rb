require 'spec_helper'
include OmniAuthSpecHelpers

feature 'User sign up via services' do
  before { OmniAuth.config.logger = Rails.logger }

  scenario 'Successfull sign up via Twitter' do
    set_omniauth
    visit root_path
    click_link 'Sign Up'
    click_link 'Sign up with Twitter'
    expect(page).to have_content('Signed in!')
  end

  scenario 'Unsuccessfull sign up via Twitter' do
    set_invalid_omniauth
    visit root_path
    click_link 'Sign Up'
    click_link 'Sign up with Twitter'
    expect(page).to have_content('Could not authenticate you from Twitter')
  end

  scenario 'Successfull sign up via Facebook' do
    set_omniauth(:facebook)
    visit root_path
    click_link 'Sign Up'
    click_link 'Sign up with Facebook'
    expect(page).to have_content('Signed in!')
  end

  scenario 'Unsuccessfull sign up via Facebook' do
    set_invalid_omniauth(provider: :facebook)
    visit root_path
    click_link 'Sign Up'
    click_link 'Sign up with Facebook'
    expect(page).to have_content('Could not authenticate you from Facebook')
  end

  scenario 'Successfull sign up via Google' do
    set_omniauth(:google_oauth2)
    visit root_path
    click_link 'Sign Up'
    click_link 'Sign up with Google'
    expect(page).to have_content('Signed in!')
  end

  scenario 'Unsuccessfull sign up via Google' do
    set_invalid_omniauth(provider: :google_oauth2)
    visit root_path
    click_link 'Sign Up'
    click_link 'Sign up with Google'
    expect(page).to have_content('Could not authenticate you from Google')
  end
end

feature 'User log in via services' do
  scenario 'Log in via Twitter' do
    set_omniauth
    visit root_path
    click_link 'Login'
    click_link 'Log in with Twitter'
    expect(page).to have_content('Signed in!')
  end

  scenario 'Log in via Facebook' do
    set_omniauth(:facebook)
    visit root_path
    click_link 'Login'
    click_link 'Log in with Facebook'
    expect(page).to have_content('Signed in!')
  end

  scenario 'Log in via Google' do
    set_omniauth(:google_oauth2)
    visit root_path
    click_link 'Login'
    click_link 'Log in with Google'
    expect(page).to have_content('Signed in!')
  end
end
