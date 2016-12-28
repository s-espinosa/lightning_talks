require 'rails_helper'

describe "When an admin tries to log in" do
  context "with valid credentials" do
    it "they can log in" do
      create(:admin, uid: 123456)
      project1 = create(:project)
      visit '/'
      expect(current_path).to eq('/login')
      click_on "Sign in with GitHub"

      expect(current_path).to eq(admin_demo_nights_path)
      within('.nav-wrapper') do
        expect(page).to have_content("Demo Nights")
        expect(page).to have_content("New Demo Night")
        expect(page).to have_content("Current Projects")
        expect(page).to have_content("New Project")
      end

      expect(page).to have_content(project1.demo_night.name)
    end
  end
end
