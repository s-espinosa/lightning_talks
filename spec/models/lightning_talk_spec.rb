require 'rails_helper'

RSpec.describe LightningTalk, type: :model do
  let(:lightning_talk) { create(:lightning_talk) }

  context "with 'accepting' lightning talk" do
    it "returns true for active lightning talk" do
      expect(lightning_talk.active?).to eq(true)
    end
  end

  context "with 'accepting' lightning talk" do
    before { lightning_talk.update(status: "voting") }

    it "returns true for active lightning talk" do
      expect(lightning_talk.active?).to eq(true)
    end
  end

  context "with closed lightning talk" do
    before { lightning_talk.update(status: "closed") }

    it "returns false for inactive lightning talk" do
      expect(lightning_talk.active?).to eq(false)
    end
  end

  context '#sorted_projects' do
    it 'returns projects based on their average total votes' do
      lightningtalk = create(:lightning_talk_with_projects)
      project1 = lightningtalk.projects.first
      project2 = lightningtalk.projects.last
      project3 = create(:project, lightning_talk: lightningtalk)
      user1 = User.first
      user2 = User.second
      project1.votes.create(user: user1, representation: 1, challenge: 1, wow: 1)
      project1.votes.create(user: user2, representation: 2, challenge: 2, wow: 2)
      project3.votes.create(user: user1, representation: 5, challenge: 5, wow: 5)
      project3.votes.create(user: user2, representation: 5, challenge: 5, wow: 5)
      projects = [project1, project2, project3]
      lightningtalk = create(:lightning_talk) 
      lightningtalk.projects << projects 
      lightningtalk_projects = lightningtalk.sorted_projects

      expect(lightningtalk_projects.first.name).to eq(project3.name)
      expect(lightningtalk_projects.last.name).to eq(project2.name)
    end
  end
end
