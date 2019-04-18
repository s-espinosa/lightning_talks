require "rails_helper"

describe "When a user visits the project index" do
  before do
    user1 = create(:user)
    @lightning_talk = create(:lightning_talk_with_projects)
    @lightning_talk.voting!
    project1, project2 = @lightning_talk.projects
    user1.votes.create(project: project1, presentation: 1, content: 1, surprise: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
  end

  it "they can edit their vote", js: true do
    visit projects_path

    within (".voted") do
      click_link("Edit Rating")
    end

    select "3", from: "vote[presentation]", visible: false
    select "3", from: "vote[content]", visible: false
    select "3", from: "vote[surprise]", visible: false
    click_on "Submit"

    expect(current_path).to eq(lightning_talk_projects_path(@lightning_talk))

  end
end
