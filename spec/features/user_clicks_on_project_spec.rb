require 'rails_helper'

describe 'When a user clicks on a project name' do
  it 'they are taken to vote on that project' do
    user = create(:user)
    project = create(:project)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit projects_path
    click_on project.name

    expect(current_path).to eq(new_project_vote_path(project))
  end
end
