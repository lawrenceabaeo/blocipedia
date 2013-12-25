require 'spec_helper'

describe 'home page' do
  it 'talks about the website' do
    visit '/'
    page.should have_content('Create and share Markdown Wikis')
  end
end