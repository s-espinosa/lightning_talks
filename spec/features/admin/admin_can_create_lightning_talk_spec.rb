require 'rails_helper'

describe "when an admin logs in" do
  it "they can create a new demo night" do
    admin = create(:admin, uid: 98765)
    demo  = create(:lightning_talk, status: 'closed')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_lightning_talks_path
    within('.closed-lightning-talks') do
      expect(page).to have_content(demo.name.humanize)
    end

    within('.active-lightning-talk') do
      click_link "Create New Lightning Talk"
    end
    fill_in "Name", with: "Lightning Talk - 1611"
    fill_in("lightning_talk[final_date]", with: "01/23/2017")
    click_button "Create Lightning Talk!"

    expect(current_path).to eq("/admin/lightning_talks/#{LightningTalk.last.id}")
    within('.projects') do
      expect(page).to have_content("No Projects Yet!")
    end

    within('.admin-tools') do
      expect(page).to have_link('open voting')
    end
    expect(LightningTalk.last.final_date).to eq(Date.new(2017, 01, 23))
  end
end
