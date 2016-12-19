class Project < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  belongs_to :demo_night

  def average_representation
    votes.average(:representation)
  end

  def average_challenge
    votes.average(:challenge)
  end

  def average_wow
    votes.average(:wow)
  end

  def average_total
    (votes.sum(:representation) + votes.sum(:challenge) + votes.sum(:wow)) / votes.count if votes.count != 0
  end

  def self.check_votes(user_id = nil)
    left_outer_joins(:votes).where(votes: { user_id: user_id })
  end
end
