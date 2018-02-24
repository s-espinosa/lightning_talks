require 'rails_helper'

describe 'When a user visits the project index' do
  it 'they can only see projects without their votes' do
    user    = create(:user)
    project = create(:project)
    Vote.create(user: user, project: project, presentation: 3, content: 3, surprise: 3)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit projects_path

    within('.unvoted') do
      expect(page).to_not have_content(project.name)
    end
  end
end
