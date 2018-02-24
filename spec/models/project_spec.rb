require "rails_helper"

describe Project do
  it { should have_many :votes }
  it { should have_many(:voters).through(:votes) }
  it { should belong_to(:lightning_talk) }
  it { should belong_to(:owner) }
  it { should validate_presence_of :name }
end
