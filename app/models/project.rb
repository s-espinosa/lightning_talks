class Project < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

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
    (votes.sum(:representation) + votes.sum(:challenge) + votes.sum(:wow)) / votes.count
  end
end
