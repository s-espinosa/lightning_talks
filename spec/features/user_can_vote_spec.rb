require 'rails_helper'

describe "When a user visits a project vote page" do
  it "they can vote on that project", js: true do
    project = create(:project)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_project_vote_path(project)
    sleep(0.1)
    all('div.select-wrapper')[0].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[1].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[2].click
    find('div.select-wrapper li', text: '3').click

    click_on "Submit"

    expect(current_path).to eq(demo_night_projects_path(project.demo_night_id))
    expect(Vote.last.wow).to eq(3)
    expect(Vote.last.user).to eq(user)
  end
end
