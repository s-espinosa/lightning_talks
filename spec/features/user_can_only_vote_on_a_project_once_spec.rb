require 'rails_helper'

describe "When a user votes on a project" do
  it "they can only vote on a project once" do
    demo_night = create(:demo_night_with_projects)
    project1, project2 =  demo_night.projects

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/demo_nights/#{demo_night.id}/projects"
    within ('.unvoted') do
      expect(page).to have_content(project1.name)
      expect(page).to have_content(project2.name)
    end

    click_link("#{project1.name}")
    select "3", from: "vote[representation]"
    select "3", from: "vote[challenge]"
    select "3", from: "vote[wow]"
    click_button("Submit")
    expect(current_path).to eq("/demo_nights/#{demo_night.id}/projects")
    within ('.unvoted') do
      expect(page).to_not have_link(project1.name)
    end

    within ('.voted') do
      expect(page).to have_content(project1.name)
    end
  end
end
