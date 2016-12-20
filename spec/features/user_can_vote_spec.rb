require 'rails_helper'

describe "When a user visits a project vote page" do
  it "they can vote on that project" do
    project = create(:project)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_project_vote_path(project)
    select "3", from: "vote[representation]"
    select "3", from: "vote[challenge]"
    select "3", from: "vote[wow]"

    click_on "Submit"

    expect(current_path).to eq(demo_night_projects_path(project.demo_night_id))
    expect(Vote.last.wow).to eq(3)
    expect(Vote.last.user).to eq(user)
  end
end
