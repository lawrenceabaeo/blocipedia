require 'spec_helper'
require 'helpers/helper'

RSpec.configure do |c|
  c.include Helpers
end

describe 'Wiki index page' do
  
  before :each do
    create(:plan) #create the only plan in our plan database
    visit root_path
  end

  describe 'New wiki button' do 

    context 'when user is not-logged-in' do 
      it 'does NOT show the New wiki button' do
        # should it show the sign up buttons? or some kind of advertisement?
        visit wikis_path
        page.should_not have_button('New wiki')
      end
    end

    context 'when user IS logged-in' do
      it 'shows the new wiki button' do
        user = create(:user)
        sign_in(user) # from Helpers module
        visit wikis_path
        page.should have_button('New wiki')
      end
    end
  end

end