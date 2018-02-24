require "rails_helper"

describe "on updating status of demo night", js: true  do
  before do
    admin  = create(:admin)
    @active = create(:lightning_talk)
    @closed = create(:lightning_talk, status: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it "only allows one active demo night - from index" do
    visit admin_lightning_talks_path
    within('.closed-lightning-talks') do
      click_link("open voting")
    end
    expect(page).to have_content("There can only be 1 active demo night at a time")
    within('.closed-lightning-talks') do
      expect(page).to have_content(@closed.name.humanize)
    end
  end

  it "allows active demo night to be closed - from index" do
    visit admin_lightning_talks_path
    within('.active-lightning-talk') do
      click_link("close")
    end

    @active.reload
    expect(page).to have_content("#{@active.name} now #{@active.status.humanize.downcase}")
    within('.closed-lightning-talks') do
      expect(page).to have_content(@active.name.humanize)
    end
  end

  it "only allows one active demo night - from show" do
    visit admin_lightning_talk_path(@closed)
    click_link("open voting")

    expect(page).to have_content("There can only be 1 active demo night at a time")
    within('.closed-lightning-talks') do
      expect(page).to have_content(@closed.name.humanize)
    end
  end

  it "allows active demo night to be closed - from show" do
    visit admin_lightning_talk_path(@active)
    click_link("close")

    @active.reload
    expect(page).to have_content("#{@active.name} now #{@active.status.humanize.downcase}")
    within('.closed-lightning-talks') do
      expect(page).to have_content(@active.name.humanize)
    end
  end
end
