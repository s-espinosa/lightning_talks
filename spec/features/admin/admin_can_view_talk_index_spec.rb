require 'rails_helper'

describe 'when an admin visits the demo night index' do
  it 'they see a list of active and closed demo nights' do
    admin = create(:admin, uid: 98765)
    demo1 = create(:lightning_talk, status: 'closed')
    demo2 = create(:lightning_talk)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_lightning_talks_path

    within('.active-lightning-talk') do
      expect(page).to have_content(demo2.name.humanize)
    end
    within('.closed-lightning-talks') do
      expect(page).to have_content(demo1.name.humanize)
    end
  end
end
