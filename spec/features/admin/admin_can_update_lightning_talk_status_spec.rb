require "rails_helper"

describe "When an admin views the demo night index", js: true  do
  before do
    admin  = create(:admin)
    @active = create(:lightning_talk)
    @closed = create(:lightning_talk, status: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it "they can open voting on a demo night" do
    visit admin_lightning_talks_path
    within('.active-lightning-talk') do
      click_link("open voting")
    end

    expect(page).to have_content("#{@active.name} now voting")
    within('.active-lightning-talk') do
      expect(page).to_not have_link('open voting')
      expect(page).to have_link('close')
    end
    @active.reload
    expect(@active.status).to eq("voting")
  end
end
