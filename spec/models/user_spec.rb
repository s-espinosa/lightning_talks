require "rails_helper"

describe User do
  it "should have submitted projects" do
    user = create(:user)
    project = create(:project, owner: user)
    expect(user.submitted_projects).to eq([project])
  end

  it "should have many voted projects" do
    user = create(:user)
    project = create(:project)
    Vote.create(user_id: user.id, project_id: project.id, presentation: 3, content: 3, surprise: 3)
    expect(user.voted_projects).to eq([project])
  end
end
