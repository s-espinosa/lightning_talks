class Project < ApplicationRecord
  has_many :votes
  has_many :voters, through: :votes, source: :user

  belongs_to :owner, class_name: "User", foreign_key: 'user_id'
  belongs_to :demo_night

  validates_presence_of :name

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
    if votes.count != 0
      (votes.sum(:representation) + votes.sum(:challenge) + votes.sum(:wow)) / votes.count
    else
      0
    end
  end

  def self.unvoted_by_user(user_id)
    projects = Vote.where(user_id: user_id).pluck(:project_id)
    where.not(id: projects)
  end

  def self.voted_by_user(user_id)
    joins(:votes).where("votes.user_id = #{user_id}")
  end

  def self.current_projects
    current_demo_night = DemoNight.currents.first
    if current_demo_night
      where(demo_night_id: current_demo_night.id)
    else
      []
    end
  end

  def self.scored_order
    sort_by { |p| p.average_total }.reverse
  end
end
