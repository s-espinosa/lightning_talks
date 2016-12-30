require 'rails_helper'

When I visit the DemoNight show page
The projects associated with that Demo Night are displayed
In order of their total average scores

describe 'admin visits demo-night show path' do
  context 'with existing demonight and voted projects' do
    scenario 'they see the projects in order from most votes to least votes' do
      user  = create(:user)
      admin = create(:admin, uid: 123456)
      demo_night = create(:demo_night_with_projects)
      project1, project2 = demo_night.projects
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      project1.votes.create(user: user, representation: 3, challenge: 3, wow: 3)
      project2.votes.create(user: user, representation: 5, challenge: 5, wow: 5)

      visit admin_demo_night_path(demo_night)

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
