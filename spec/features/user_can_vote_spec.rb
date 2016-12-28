require 'rails_helper'

describe "When a user visits a project vote page" do
  xit "they can vote on that project", js: true do
    # As a default user
    user1, user2 = create_list(:user, 2)
    # If there is an active demo night
    # And the demo night is accepting votes
    demo = create(:demo_night_with_projects, status: "voting")
    # And I have not voted on any projects
    # And another user has voted on all projects
    demo.projects.each do |project|
      project.votes.create(user: user2,
                           project: project,
                           representation: 3,
                           challenge: 3,
                           wow: 3)
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    # From the page with all of the regsistered projects
    visit projects_path
    # I see a list of all projects under "Unvoted"
    save_and_open_page
    # If I follow one of the links to vote on a project

    # And enter votes for that project
    # sleep(0.1)
    all('div.select-wrapper')[0].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[1].click
    find('div.select-wrapper li', text: '3').click
    all('div.select-wrapper')[2].click
    find('div.select-wrapper li', text: '3').click

    # And click submit
    click_on "Submit"

    # I am redirected back to the index page
    expect(current_path).to eq(demo_night_projects_path(project.demo_night_id))
    # And I see the project name under the header "Already Voted"

    # And other projects are still under the header 'Unvoted'

    # And my votes for the project are registered
    expect(Vote.last.wow).to eq(3)
    expect(Vote.last.user).to eq(user)



  end
end
