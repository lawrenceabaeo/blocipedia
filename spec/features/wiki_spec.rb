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
    it 'shows error message when title too short' do
      user = create(:user)
      sign_in(user) # from Helpers module
      visit wikis_path
      click_on 'New wiki'
      fill_in 'wiki_title_input', with: "x"
      fill_in 'wiki_body', with: "Pee la Peep"
      click_on 'Save'
      page.should have_content("Title is too short")
    end
    it 'shows error message when body too short' do
      user = create(:user)
      sign_in(user) # from Helpers module
      visit wikis_path
      click_on 'New wiki'
      fill_in 'wiki_title_input', with: "Poop dee doopo"
      fill_in 'wiki_body', with: "x"
      click_on 'Save'
      page.should have_content("Body is too short")
    end
    it 'shows Wiki was saved message' do
        user = create(:user)
        sign_in(user) # from Helpers module
        visit wikis_path
        click_on 'New wiki'
        fill_in 'wiki_title_input', with: "Poop dee doop"
        fill_in 'wiki_body', with: "Pee la Peep"
        click_on 'Save'
        page.should have_content("Wiki was saved.")
    end
  end

  describe 'Existing wiki page' do
    it 'has title and body of an existing wiki' do 
      wiki = FactoryGirl.create :wiki
      visit wiki_path(wiki)
      page.should have_content(wiki.title)
      page.should have_content(wiki.body)
    end
    it 'has edit button' do
      wiki = FactoryGirl.create :wiki
      visit wiki_path(wiki)
      page.should have_button('Edit')
      page.should have_content('Sign out')  # NOTE: Intentionally making this fail - TODO: make wiki show page have authorized edit button. 
    end
  end

  describe 'Edit wiki page' do
    it 'has title and body of an existing wiki' do 
      wiki = FactoryGirl.create :wiki
      visit edit_wiki_path(wiki)
      expect(page).to have_field('wiki_title_input', with: wiki.title)
      expect(page).to have_field('wiki_body', with: wiki.body)
    end
    it 'has Update button' do
      wiki = FactoryGirl.create :wiki
      visit edit_wiki_path(wiki)
      page.should have_button('Update')
      page.should have_content('Sign out')  # NOTE: Intentionally making this fail - TODO: make wiki show page have authorized edit button. 
    end
    it 'shows an updated flash message after submitting edit' do
      wiki = FactoryGirl.create :wiki
      visit edit_wiki_path(wiki)
      title = "Poop dee doop"
      body = "Pee la Peep"
      fill_in 'wiki_title_input', with: title
      fill_in 'wiki_body', with: body
      click_on 'Update'
      page.should have_content("Wiki was updated.")
    end
    it 'shows updated title and body on wiki page after submitting edit' do 
      wiki = FactoryGirl.create :wiki
      visit edit_wiki_path(wiki)
      title = "Poop dee doop"
      body = "Pee la Peep"
      fill_in 'wiki_title_input', with: title
      fill_in 'wiki_body', with: body
      click_on 'Update'
      page.should have_content(title)
      page.should have_content(body)
    end
  end  

  describe 'Markdown' do 
    it 'does not show markdown markup in title' do
      wiki = FactoryGirl.create :wiki
      title =  "*Barry Manilow*"
      wiki.update_attribute(:title, title)
      visit wiki_path(wiki)
      page.should_not have_content(title)
    end
    it 'does not show markdown markup in body' do
      wiki = FactoryGirl.create :wiki
      body =  "*What would you do for a Klondike Bar*"
      wiki.update_attribute(:body, body)
      visit wiki_path(wiki)
      page.should_not have_content(body)
    end
  end

  describe 'My Wikis' do 
    it 'shows the wikis I own on the wiki index page' do
      wikibody = "Generic body"

      user0 = create(:user) 
      title0 = "My wiki title 0"
      wiki0 = user0.wikis.create(title: title0, body: wikibody)

      user1 = create(:user)
      title1 = "My wiki title 1"
      wiki1 = user1.wikis.create(title: title1, body: wikibody)

      sign_in(user1) # from Helpers module
      visit wikis_path
      within('#my_wikis') { expect(page).to have_content(title1) }
      within('#my_wikis') { expect(page).to_not have_content(title0) }
    end

    it 'has edit link for entry' do 
      user_makes_wiki_signs_in_and_goes_to_wikis
      within('#my_wikis') { expect(page).to have_link("edit") }
    end

    it 'has delete link for entry' do 
      user_makes_wiki_signs_in_and_goes_to_wikis
      within('#my_wikis') { expect(page).to have_link("delete") }
    end

    it 'shows delete message after deleting' do
      user_makes_wiki_signs_in_and_goes_to_wikis
      click_on 'delete'
      page.should have_content("Wiki was successfully deleted.")
    end

    it 'does not show wiki entry after deletion' do 
      user = create(:user) 
      title = "My wiki title 0"
      wikibody = "Generic body"
      wiki = user.wikis.create(title: title, body: wikibody)
      sign_in(user) # from Helpers module
      visit wikis_path
      click_on 'delete'
      page.should_not have_content(title)
    end
  end

end

private 

def user_makes_wiki_signs_in_and_goes_to_wikis
    user = create(:user) 
    title = "My wiki title 0"
    wikibody = "Generic body"
    wiki = user.wikis.create(title: title, body: wikibody)
    sign_in(user) # from Helpers module
    visit wikis_path
end