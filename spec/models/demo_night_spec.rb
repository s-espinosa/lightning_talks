require 'rails_helper'

RSpec.describe DemoNight, type: :model do
  let(:demo_night) { create(:demo_night) }

  context "with 'accepting' demo night" do
    it "returns true for active demo night" do
      expect(demo_night.active?).to eq(true)
    end
  end

  context "with 'accepting' demo night" do
    before { demo_night.update(status: "voting") }

    it "returns true for active demo night" do
      expect(demo_night.active?).to eq(true)
    end
  end

  context "with closed demo night" do
    before { demo_night.update(status: "closed") }

    it "returns false for inactive demo night" do
      expect(demo_night.active?).to eq(false)
    end
  end

end
