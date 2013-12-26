require 'spec_helper'

describe 'Buying Premium' do
  
  before :each do
    create(:plan) #create the only plan in our plan database
    visit '/'
  end

  describe 'clicking home page Premium Plan button' do 

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
        fill_in 'card_number', with: "4242 4242 4242 4242"
        fill_in 'card_code', with: "123"
        select '7 - July', from: "card_month"
        select  '2015', from: "card_year"
        # click_button 'Subscribe' # Need to figure out how to use javascript in our headless vagrant environment
        # page.should have_content('Thank you for subscribing!') 
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

end