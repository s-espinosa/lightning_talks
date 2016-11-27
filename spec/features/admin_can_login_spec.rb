require 'rails_helper'

describe "When an admin tries to log in" do
  context "with valid credentials" do
    it "they can log in" do
      create(:admin, uid: 123456)
      visit '/'
      expect(current_path).to eq('/login')
      click_on "Sign in with GitHub"

      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end
