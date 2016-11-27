require 'rails_helper'

describe "When an admin visits the admin projects path" do
  it "they see a list of projects" do
    user  = create(:user)
    admin = create(:admin, uid: 123456)
    project1, project2 = create_list(:project, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    project1.votes.create(user: user, representation: 5, challenge: 5, wow: 5)
    project1.votes.create(user: user, representation: 3, challenge: 3, wow: 3)
    project2.votes.create(user: user, representation: 2, challenge: 2, wow: 2)

    visit admin_dashboard_path

    within("tr:nth-of-type(2)") do
      within(":nth-child(1)") do
        expect(page).to have_content(project1.name)
      end
      within(":nth-child(2)") do
        expect(page).to have_content(project1.group_members)
      end
      within(":nth-child(3)") do
        expect(page).to have_content("4")
      end
      within(":nth-child(4)") do
        expect(page).to have_content("4")
      end
      within(":nth-child(5)") do
        expect(page).to have_content("4")
      end
      within(":nth-child(6)") do
        expect(page).to have_content("12")
      end
    end
    within("tr:nth-of-type(3)") do
      expect(page).to have_content(project2.name)
    end
  end
end
