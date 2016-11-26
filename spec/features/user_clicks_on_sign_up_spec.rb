require 'rails_helper'

describe 'When a user clicks on Sign Up' do
  it 'they are taken to create a new project' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_on "Sign Up"

    expect(current_path).to eq(new_project_path)
  end
end
