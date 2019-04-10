require 'rails_helper'

describe 'admin visits project show path' do
  context 'with existing votes with comments' do
    scenario 'they see the information for that project including feedback' do
      user1, user2  = create_list(:user, 2)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      lightning_talk = create(:lightning_talk_with_projects)
      project1, project2 = lightning_talk.projects
      project1.votes.create(user: user1, presentation: 3, content: 3, surprise: 3, feedback: "Great job!")
      project1.votes.create(user: user2, presentation: 5, content: 5, surprise: 5, feedback: "Lots of colors!")
      project2.votes.create(user: user1, presentation: 5, content: 5, surprise: 5)

      visit admin_lightning_talk_path(lightning_talk)
      click_on project1.name

      expect(page).to have_content("Presentation: 4.0")
      expect(page).to have_content("Content: 4.0")
      expect(page).to have_content("Surprise: 4.0")
      expect(page).to have_content("Great job!")
      expect(page).to have_content("Lots of colors!")

      visit admin_lightning_talk_path(lightning_talk)
      click_on project2.name

      expect(page).to have_content("Presentation: 5")
      expect(page).to have_content("Content: 5")
      expect(page).to have_content("Surprise: 5")
      expect(page).to have_content("No feedback provided.")
    end
  end
end
