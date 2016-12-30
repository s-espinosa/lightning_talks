require "rails_helper"

describe Project do
  it { should have_many :votes }
  it { should have_many(:voters).through(:votes) }
  it { should belong_to(:demo_night) }
  it { should belong_to(:owner) }
  it { should validate_presence_of :name }

  context '#scored_order' do
    it 'returns projects based on their average total votes' do
      user1 = create(:user)
      user2 = create(:user)
      project1 = create(:project)
      project2 = create(:project)
      project3 = create(:project)
      project1.votes.create(user: user1, representation: 1, challenge: 1, wow: 1)
      project1.votes.create(user: user2, representation: 2, challenge: 2, wow: 2)
      project3.votes.create(user: user1, representation: 5, challenge: 5, wow: 5)
      project3.votes.create(user: user1, representation: 5, challenge: 5, wow: 5)
      projects = [project1, project2, project3]
      demonight = create(:demo_night) 
      demonight.projects << projects 
      demonight_projects = demonight.projects.scored_order

      expect(demonight_projects.first.name).to eq(project3.name)
      expect(demonight_projects.last.name).to eq(project2.name)
    end
  end
end
