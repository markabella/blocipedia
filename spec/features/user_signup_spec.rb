require 'rails_helper'

describe 'UserSignup' do
  it 'allows a user to register' do
      visit new_user_registration_path
      fill_in 'Email', :with => 'newuser@example.com'
      fill_in 'Password', :with => 'userpassword'
      fill_in 'Password confirmation', :with => 'userpassword'
      
      click_button 'Sign up'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end