require 'rails_helper'

describe 'When an admin visits the demo-night show path' do
  context 'with existing projects' do
    scenario 'they see notes for projects' do
      user = create(:user)
      admin = create(:admin, uid: 123456)
      demo_night = create(:demo_night_with_projects)
      project1, project2 = demo_night.projects
      project1.note = "make sure I win"
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_demo_night_path(demo_night)

      within('.projects > table > tbody') do
        within('tr:nth-child(2)') do
          expect(page).to have_content(project1.note)
        end
      end
    end
  end
end
