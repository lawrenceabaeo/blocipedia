require 'spec_helper'
require 'helpers/helper'

RSpec.configure do |c|
  c.include Helpers
end

describe 'Buying Premium' do
  
  before :each do
    create(:plan) #create the only plan in our plan database
    visit root_path
  end

  describe 'clicking home page Premium Plan button' do 

    context 'when user is not-logged-in' do 
      it 'shows sign-up page' do
        click_on 'Premium Plan'
        page.should have_content('Password confirmation')    
      end
    end

    context 'when logged-in but not Premium' do 
      it 'lets user order', :js => true do
        user = create(:user)
        sign_in(user) # from Helpers module
        page.should have_content('Signed in successfully.')
        click_on 'Premium Plan'
        page.should have_content('Credit Card Number')
        fill_in 'card_number', with: "4242 4242 4242 4242"
        fill_in 'card_code', with: "123"
        select '7 - July', from: "card_month"
        select  '2015', from: "card_year"
        click_button 'Subscribe' # Need to figure out how to use javascript in our headless vagrant environment
        page.should have_content('Thank you for subscribing!') # NOTE: Need to eventually replace this with correct landing page
        click_on 'Blocipedia'
        click_on 'Premium Plan'
        page.should have_content("Totes Magotes!") # NOTE: Intentionally making this fail so that I will remember to implement the wiki page with the thanks notice. 
      end
    end

    context 'when user is already a Premium Plan subscriber' do 
      it 'shows the wiki page with thanks notice' do
        subscription = FactoryGirl.create :subscription
        user = subscription.user
        sign_in(user) # from Helpers module
        page.should have_content('Signed in successfully.')
        click_on 'Premium Plan'
        page.should have_content("Totes Magotes") # NOTE: Intentionally making this fail so that I will remember to implement the wiki page with the thanks notice. 
      end
    end
   
  end

end