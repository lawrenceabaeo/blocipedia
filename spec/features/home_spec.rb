require 'spec_helper'
require 'helpers/helper'

describe 'Home page' do

  it 'talks about the website' do
    visit root_path
    page.should have_content('Create and share Markdown Wikis')
  end
  
  describe 'Wikis link' do 

    context 'when user is not logged in' do 
      it 'has wikis link' do
        visit root_path
        page.should have_link('Wikis')
      end
      it 'lands on wiki page with NO My wikis section' do
        visit root_path
        click_on 'Wikis'
        page.should_not have_content("My wikis")
      end
    end

    context 'when user IS logged in' do
      it 'has wikis link' do
        create(:plan) #create the only plan in our plan database
        visit root_path
        user = create(:user)
        sign_in(user) # from Helpers module
        visit root_path
        page.should have_link('Wikis')
      end
      it 'lands on wiki page WITH My wikis section' do
        create(:plan) #create the only plan in our plan database
        visit root_path
        user = create(:user)
        sign_in(user) # from Helpers module
        visit root_path
        click_on 'Wikis'
        page.should have_content("My wikis")
      end
    end
  
  end

end