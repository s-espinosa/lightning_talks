require 'rails_helper'

describe 'admin visits lightning-talk show path' do
  context 'with existing lightningtalk and voted projects' do
    scenario 'they see the projects in order from most votes to least votes' do
      user  = create(:user)
      admin = create(:admin, uid: 123456)
      lightning_talk = create(:lightning_talk_with_projects)
      project1, project2 = lightning_talk.projects
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      project1.votes.create(user: user, representation: 3, challenge: 3, wow: 3)
      project2.votes.create(user: user, representation: 5, challenge: 5, wow: 5)

      visit admin_lightning_talk_path(lightning_talk)

      within('.projects > table > tbody') do
        within('tr:nth-child(1)') do
          expect(page).to have_content(project2.name)
          expect(page).to have_content(project2.group_members)
        end
        within('tr:nth-child(2)') do
          expect(page).to have_content(project1.name)
        end
      end
    end
  end
end
