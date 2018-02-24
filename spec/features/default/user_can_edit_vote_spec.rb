require "rails_helper"

describe "When a user visits the project index" do
  before do
    user1 = create(:user)
    @lightning_talk = create(:lightning_talk_with_projects)
    @lightning_talk.voting!
    project1, project2 = @lightning_talk.projects
    user1.votes.create(project: project1, representation: 1, challenge: 1, wow: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
  end

  it "they can edit their vote", js: true do
    visit projects_path

    within (".voted") do
      click_link("Edit Rating")
    end

    all('div.select-wrapper')[0].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[1].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[2].click
    find('div.select-wrapper li', text: '3').click
    click_on "Submit"

    expect(current_path).to eq(lightning_talk_projects_path(@lightning_talk))

  end
end
