module LoginSteps
  def fill_in_login_form(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'foobar81'
    check 'Remember me'
    click_button 'Log in to your account'
  end
end
