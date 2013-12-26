require 'spec_helper'

describe 'asks not-logged-in users to sign up' do
  
  before :each do
    create(:plan) #create the only plan in our plan database
  end
  
  it 'sends not-logged-in user to sign up' do
    visit '/'
    click_on 'Premium Plan'
    page.should have_content('Password confirmation')    
  end

  it 'shows ordering page to logged-in users' do
    visit '/'
    @user = create(:user)
    click_on 'Sign In'
    fill_in 'Email', with: @user[:email]
    fill_in 'Password', with: "helloworld" # yup, hardcoding this here, I have a delicious bookmark somwhere explaining why
    click_button 'Sign in'    
    page.should have_content('Signed in successfully.')
    click_on 'Premium Plan'
    page.should have_content('Credit Card Number')
  end
end