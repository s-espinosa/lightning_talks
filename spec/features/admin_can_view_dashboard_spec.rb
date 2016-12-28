require 'rails_helper'

describe "When an admin visits the admin dashboard path" do
  it "they see a list of projects" do
    user  = create(:user)
    admin = create(:admin, uid: 123456)
    demo_night = create(:demo_night_with_projects)
    project1, project2 = demo_night.projects
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    project1.votes.create(user: user, representation: 5, challenge: 5, wow: 5)
    project1.votes.create(user: user, representation: 3, challenge: 3, wow: 3)
    project2.votes.create(user: user, representation: 2, challenge: 2, wow: 2)

    visit admin_demo_night_path(demo_night)
    within("tr:nth-of-type(2)") do
      within(":nth-child(1)") do
        expect(page).to have_content(project2.name)
      end
      within(":nth-child(2)") do
        expect(page).to have_content(project2.group_members)
      end
      within(":nth-child(3)") do
        expect(page).to have_content("2.0")
      end
      within(":nth-child(4)") do
        expect(page).to have_content("2.0")
      end
      within(":nth-child(5)") do
        expect(page).to have_content("2.0")
      end
      within(":nth-child(6)") do
        expect(page).to have_content("6")
      end
    end
  end
end
