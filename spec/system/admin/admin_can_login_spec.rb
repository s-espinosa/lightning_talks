require 'rails_helper'

describe "When an admin tries to log in" do
  context "with valid credentials and a current lightning talk" do
    it "they can log in and see projects" do
      create(:admin, uid: 123456)
      project1 = create(:project)
      visit '/'
      expect(current_path).to eq('/login')
      click_on "Sign in with GitHub"

      expect(current_path).to eq(admin_lightning_talks_path)
      within('.nav-wrapper') do
        expect(page).to have_content("Lightning Talks")
        expect(page).to have_content("Current Talks")
        expect(page).to have_content("New Talk")
      end

      expect(page).to have_content(project1.lightning_talk.name.humanize)
    end
  end

  context "with valid credentials and a current lightning talk" do
    it "they can log in and see a button to create a new lightning talk" do
      create(:admin, uid: 123456)
      visit '/'
      expect(current_path).to eq('/login')
      click_on "Sign in with GitHub"

      expect(current_path).to eq(admin_lightning_talks_path)
      within('.nav-wrapper') do
        expect(page).to have_content("New Lightning Talk")
      end
    end
  end

end
