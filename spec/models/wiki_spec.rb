require 'spec_helper'

describe Wiki do
  it "has a valid factory" do 
    create(:wiki).should be_valid
  end
  it { should belong_to :user }
  it { should have_many :collaborators}
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:public_access)}
  it "has true for public_access by default" do
    Wiki.new.public_access.should be_true
  end
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:body)}
  it { should ensure_length_of(:title).is_at_least(3)}
  it { should ensure_length_of(:body).is_at_least(5)}
end
