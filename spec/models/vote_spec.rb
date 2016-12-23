require "rails_helper"

describe Vote do
  it { should belong_to :user }
  it { should belong_to :project }
  it "validates uniqueness of user and project on vote" do
    user = create(:user)
    project = create(:project)
    vote = Vote.create!(user_id: user.id, project_id: project.id)
    should validate_uniqueness_of(:user_id).scoped_to(:project_id)
  end
end
