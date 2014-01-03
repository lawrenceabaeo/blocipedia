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

  describe 'Submit new wiki' do
    before :each do
      user = create(:user)
      sign_in(user) # from Helpers module
      visit wikis_path
      click_on 'New wiki'
    end
    
    it 'shows error message when title too short' do
      fill_in 'wiki_title_input', with: "t"
      fill_in 'wiki_body', with: "Pee la Peep"
      click_on 'Save'
      page.should have_content("Title is too short")
    end
    it 'shows error message when body too short' do
      fill_in 'wiki_title_input', with: "Poop dee doopo"
      fill_in 'wiki_body', with: "b"
      click_on 'Save'
      page.should have_content("Body is too short")
    end
    it 'shows Wiki was saved message' do
      fill_in 'wiki_title_input', with: "Poop dee doop"
      fill_in 'wiki_body', with: "Pee la Peep"
      click_on 'Save'
      page.should have_content("Wiki was saved.")
    end
  end

  describe 'Existing wiki page' do
    before :each do
      @wiki = FactoryGirl.create :wiki
      visit wiki_path(@wiki)
    end
    it 'has title and body of an existing wiki' do 
      page.should have_content(@wiki.title)
      page.should have_content(@wiki.body)
    end
    it 'has edit button' do
      page.should have_button('Edit')
      page.should have_content('Sign out')  # NOTE: Intentionally making this fail - TODO: make wiki show page have authorized edit button. 
    end
  end

  describe 'Edit wiki page' do
    before :each do
      @wiki = FactoryGirl.create :wiki
      @title = "Poop dee doop"
      @body = "Pee la Peep"
      visit edit_wiki_path(@wiki)
    end
    
    it 'has title and body of an existing wiki' do 
      expect(page).to have_field('wiki_title_input', with: @wiki.title)
      expect(page).to have_field('wiki_body', with: @wiki.body)
    end
    
    it 'has Update button' do
      page.should have_button('Update')
      page.should have_content('Sign out')  # NOTE: Intentionally making this fail - TODO: make wiki show page have authorized edit button. 
    end
    
    context 'owner is logged-in' do
      it 'displays public access option' do
        # expect(page).to have_checked_field("public_access")
        page.should have_content('Public access')
      end
    end


    describe 'after submitting edit' do
      before :each do
        fill_in 'wiki_title_input', with: @title
        fill_in 'wiki_body', with: @body
        click_on 'Update'
      end
      
      it 'shows an updated flash message' do
        page.should have_content("Wiki was updated.")
      end
      it 'shows updated title and body on wiki page' do 
        page.should have_content(@title)
        page.should have_content(@body)
      end
    end
  
  end  

  describe 'Markdown' do 
    before :each do 
      @wiki = FactoryGirl.create :wiki
      @title =  "*Barry Manilow*"
      @body =  "*What would you do for a Klondike Bar*"
      @wiki.update_attribute(:title, title)
      @wiki.update_attribute(:body, body)
      visit wiki_path(@wiki)
    end
    it 'does not show markdown markup in title' do
      page.should_not have_content(@title)
    end
    it 'does not show markdown markup in body' do
      page.should_not have_content(body)
    end
  end

  describe 'My Wikis' do 
    before :each do 
      @user = create(:user) 
      @title = "My wiki title 0"
      @wikibody = "Generic body"
      @wiki = @user.wikis.create(title: @title, body: @wikibody)
      sign_in(@user) # from Helpers module
      visit wikis_path
    end

    it 'shows the wikis I own on the wiki index page' do
      user1 = create(:user)
      title1 = "My wiki title 1"
      wiki1 = user1.wikis.create(title: title1, body: @wikibody)
      click_on("Sign out") # sign out the user that was in the before block 
      sign_in(user1) # from Helpers module
      visit wikis_path
      within('#my_wikis') { expect(page).to have_content(title1) }
      within('#my_wikis') { expect(page).to_not have_content(@title) }
    end

    it 'has edit link for entry' do 
      within('#my_wikis') { expect(page).to have_link("edit") }
    end

    it 'has delete link for entry' do 
      within('#my_wikis') { expect(page).to have_link("delete") }
    end

    describe 'page after deleting' do 
      before :each do 
        click_on 'delete'
      end

      it 'shows delete message after deleting' do  
        page.should have_content("Wiki was successfully deleted.")
      end

      it 'does not show wiki entry after deletion' do 
        page.should_not have_content(@title)
      end
    end
  end

end
