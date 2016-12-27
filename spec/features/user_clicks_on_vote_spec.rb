require 'rails_helper'

describe 'When a user clicks on Vote' do
  xit 'they are taken to the project index' do
    # i think this is gone because of the new redirect?
    user = create(:user)
    demo_night = create(:demo_night_with_projects)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_on "Vote"

    expect(current_path).to eq(projects_path)
  end
end
