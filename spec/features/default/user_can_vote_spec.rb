require 'rails_helper'

describe "When a user visits a project vote page" do
  it "they can vote on that project", js: true do
    user1, user2 = create_list(:user, 2)
    demo = create(:demo_night_with_projects, status: "voting")
    demo.projects.each do |project|
      project.votes.create(user: user2,
                           project: project,
                           representation: 3,
                           challenge: 3,
                           wow: 3)
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit projects_path
    within(".unvoted") do
      expect(page).to have_content(demo.projects[0].name)
      expect(page).to have_content(demo.projects[1].name)
      click_link("Rate", href: new_project_vote_path(demo.projects[0]))
    end

    all('div.select-wrapper')[0].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[1].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[2].click
    find('div.select-wrapper li', text: '3').click
    click_on "Submit"

    expect(current_path).to eq(demo_night_projects_path(demo))
    within(".unvoted") do
      expect(page).to have_content(demo.projects[1].name)
    end
    within(".voted") do
      expect(page).to have_content(demo.projects[0].name)
    end
    expect(Vote.last.wow).to eq(3)
    expect(Vote.last.user).to eq(user1)
  end
end
