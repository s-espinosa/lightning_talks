require 'rails_helper'

describe "When a user visits a project vote page" do
  it "they can vote on that project", js: true do
    user1, user2 = create_list(:user, 2)
    demo = create(:lightning_talk, status: "voting")
    demo.projects << create(:project, project_type: "BE Mod 2")
    demo.projects << create(:project, project_type: "FE Mod 2")
    demo.projects << create(:project, project_type: "BE Mod 3")
    demo.projects << create(:project, project_type: "FE Mod 3")
    demo.projects << create(:project, project_type: "BE Mod 4")
    demo.projects << create(:project, project_type: "FE Mod 4")
    demo.projects[3..-1].each do |project|
      project.votes.create(user: user2,
                           project: project,
                           presentation: 3,
                           content: 3,
                           surprise: 3)
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit projects_path

    all('div.select-wrapper')[0].click
    find('div.select-wrapper li', text: 'BE Mod 2').click

    within(".unvoted") do
      expect(page).to have_content(demo.projects[0].name)
      expect(page).to_not have_content(demo.projects[1].name)
      expect(page).to_not have_content(demo.projects[2].name)
      expect(page).to_not have_content(demo.projects[3].name)
      expect(page).to_not have_content(demo.projects[4].name)
      expect(page).to_not have_content(demo.projects[5].name)
      click_link("Rate", href: new_project_vote_path(demo.projects[0]))
    end

    all('div.select-wrapper')[0].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[1].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[2].click
    find('div.select-wrapper li', text: '3').click
    click_on "Submit"

    expect(current_path).to eq(lightning_talk_projects_path(demo))
    within(".unvoted") do
      expect(page).to_not have_content(demo.projects[0].name)
      expect(page).to have_content(demo.projects[1].name)
      expect(page).to have_content(demo.projects[2].name)
      expect(page).to have_content(demo.projects[3].name)
      expect(page).to have_content(demo.projects[4].name)
      expect(page).to have_content(demo.projects[5].name)
    end

    within(".voted") do
      expect(page).to have_content(demo.projects[0].name)
    end

    all('div.select-wrapper')[0].click
    find('div.select-wrapper li', text: 'BE Mod 4').click

    within(".unvoted") do
      expect(page).to_not have_content(demo.projects[0].name)
      expect(page).to_not have_content(demo.projects[1].name)
      expect(page).to_not have_content(demo.projects[2].name)
      expect(page).to_not have_content(demo.projects[3].name)
      expect(page).to have_content(demo.projects[4].name)
      expect(page).to_not have_content(demo.projects[5].name)
    end

    within(".voted") do
      expect(page).to_not have_content(demo.projects[0].name)
    end


    expect(Vote.last.surprise).to eq(3)
    expect(Vote.last.user).to eq(user1)
  end
end
