require 'rails_helper'

describe 'When a user clicks on Vote' do
  it 'they are taken to the project index' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_on "Vote"

    expect(current_path).to eq(projects_path)
  end
end
