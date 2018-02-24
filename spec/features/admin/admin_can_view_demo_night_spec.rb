require 'rails_helper'

describe "When an admin visits the admin lightning talk show path" do
  it "they see a list of projects" do
    user  = create(:user)
    admin = create(:admin, uid: 123456)
    lightning_talk = create(:lightning_talk_with_projects)
    project1, project2 = lightning_talk.projects
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    project1.votes.create(user: user, presentation: 5, content: 5, surprise: 5)
    project1.votes.create(user: user, presentation: 3, content: 3, surprise: 3)
    project2.votes.create(user: user, presentation: 2, content: 2, surprise: 2)

    visit admin_lightning_talk_path(lightning_talk)
    within('.card-content.white-text') do
      expect(page).to have_content("Number of Projects: 2")
    end
    within('.projects > table > tbody') do
      within('tr:nth-child(1)') do
        expect(page).to have_content(project1.name)
        expect(page).to have_content(project1.group_members)
      end
      within('tr:nth-child(2)') do
        expect(page).to have_content(project2.name)
      end
    end

  end
end
