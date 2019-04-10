require 'rails_helper'

describe 'When a user visits the project index' do
  it 'they do not see notes for projects' do
    user    = create(:user)
    project = create(:project)
    project.update(note: "make sure I win")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit projects_path

    expect(page).to_not have_content(project.note)
  end
end
