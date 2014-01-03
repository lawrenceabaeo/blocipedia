require 'spec_helper'

describe Collaborator do
  it { should belong_to(:user) }
  it { should belong_to(:wiki) }
end
