require "rails_helper"

describe Project do
  it { have_many :votes }
end
