require 'rails_helper'

describe 'When an admin visits the lightning-talk show path' do
  context 'with existing projects' do
    scenario 'they see notes for projects' do
      user = create(:user)
      admin = create(:admin, uid: 123456)
      lightning_talk = create(:lightning_talk_with_projects)
      project1, project2 = lightning_talk.projects
      project1.update(note: "make sure I win")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_lightning_talk_path(lightning_talk)

      within('.projects > table > tbody') do
        within('tr:nth-child(2)') do
          expect(page).to have_content(project1.note)
        end
      end
    end
  end
end
