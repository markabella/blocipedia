require 'rails_helper'

  describe "UserSignin" do
    user = User.new(
    :email => 'person@example.com',
    :password => 'password1',
    :password_confirmation => 'password1'
    )
    user.skip_confirmation!
    user.save

    it "allows a registered user to sign in and sign out" do
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      
      click_button "Log in"
      expect(page).to have_content "Signed in successfully."
      
      click_link('Sign Out')
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end

    it "does not allow an unregistered user to sign in" do
      visit new_user_session_path
      fill_in "Email", :with => "notarealuser@example.com"
      fill_in "Password", :with => "fakepassword"
      
      click_button "Log in"
      expect(page).to have_content "Invalid Email or password."
    end
  end