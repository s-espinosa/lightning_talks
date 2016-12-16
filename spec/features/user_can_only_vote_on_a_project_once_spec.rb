require 'rails_helper'

describe "When a user votes on a project" do
  it "they can only vote on a project once" do
    demo_night = create(:demo_night_with_projects)
    project1, project2 =  demo_night.projects

    # As a user
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # When I visit /demo_night/:id/projects
    visit "/demo_nights/#{demo_night.id}/projects"
    # I am presented with a list of projects
    within ('.unvoted') do
      expect(page).to have_content(project1.name)
      expect(page).to have_content(project2.name)
    end

    # When i click on a project
    click_link("#{project1.name}")
    # and I select a score for each of the categories
    select "3", from: "vote[representation]"
    select "3", from: "vote[challenge]"
    select "3", from: "vote[wow]"
    # and I click on submit
    click_button("Submit")
    # I am returned to /demo_night/:id/projects
    expect(current_path).to eq("/demo_night/#{demo_night.id}/projects")
    # And the project name of the project that I just voted on is no longer shown.
    within ('.unvoted') do
      expect(page).to_not have_content(project1.name)
    end
  end
end
