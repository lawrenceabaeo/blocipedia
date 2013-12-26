require 'spec_helper'

describe 'asks not-logged-in users to sign up' do
  it 'sends not-logged-in user to sign up' do
    visit '/'
    click_on 'Premium Plan'
    page.should have_content('Password confirmation')
  end
end