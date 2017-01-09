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
      (votes.sum(:representation) + votes.sum(:challenge) + votes.sum(:wow)) / votes.count.to_f
    else
      0
    end
  end

  def self.unvoted_by_user(user_id)
    projects = Vote.where(user_id: user_id).pluck(:project_id)
    eligible = ["BE Mod 3", "FE Mod 3", "BE Mod 4", "FE Mod 4"]
    where.not(id: projects).where(project_type: eligible)
  end

  def self.voted_by_user(user_id)
    joins(:votes).where("votes.user_id = #{user_id}")
  end

  def self.ineligible
    eligible = ["BE Mod 3", "FE Mod 3", "BE Mod 4", "FE Mod 4"]
    where.not(project_type: eligible)
  end

  def self.current_projects
    current_demo_night = DemoNight.currents.first
    if current_demo_night
      where(demo_night_id: current_demo_night.id)
    else
      []
    end
  end
end
