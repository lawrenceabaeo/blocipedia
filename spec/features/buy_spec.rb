require 'spec_helper'

describe 'Clicking Premium Plan' do
  
  before :each do
    create(:plan) #create the only plan in our plan database
    visit '/'
  end

  context 'when user is not-logged-in' do 
    it 'shows sign-up page' do
      click_on 'Premium Plan'
      page.should have_content('Password confirmation')    
    end
  end

  context 'when logged-in but not Premium' do 
    it 'shows the ordering page' do
      user = create(:user)
      click_on 'Sign In'
      fill_in 'Email', with: user[:email]
      fill_in 'Password', with: "helloworld" # yup, hardcoding this here, I have a delicious bookmark somwhere explaining why
      click_button 'Sign in'    
      page.should have_content('Signed in successfully.')
      click_on 'Premium Plan'
      page.should have_content('Credit Card Number')
    end
  end

  context 'when user is already a Premium Plan subscriber' do 
    it 'shows the wiki page with thanks notice' do
      user = create(:user)
      user.update_attribute(:role, 'premium')
      click_on 'Sign In'
      fill_in 'Email', with: user[:email]
      fill_in 'Password', with: "helloworld" # yup, hardcoding this here, I have a delicious bookmark somwhere explaining why
      click_button 'Sign in'
      page.should have_content('Signed in successfully.')
      click_on 'Premium Plan'
      page.should have_content('Thanks! You are already awesome and stuff!')
      # NOTE: Intentionally making this fail so that I will remember to implement the wiki page with the thanks notice. 
    end
  end
   
end