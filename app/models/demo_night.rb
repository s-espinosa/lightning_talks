class DemoNight < ApplicationRecord
  has_many :projects
  has_many :votes, through: :projects

  enum status: [:accepting_submissions, :voting, :closed]

  def self.current
    where.not(status: "closed").first
  end

  def self.currents
    where.not(status: "closed")
  end

  def active?
    status != "closed"
  end
end
