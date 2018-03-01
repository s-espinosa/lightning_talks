class Project < ApplicationRecord
  has_many :votes
  has_many :voters, through: :votes, source: :user

  belongs_to :owner, class_name: "User", foreign_key: 'user_id'
  belongs_to :lightning_talk

  validates_presence_of :name

  def number_of_votes
    votes.count
  end

  def average_presentation
    votes.average(:presentation).round(3) if votes.count != 0
  end

  def average_content
    votes.average(:content).round(3) if votes.count != 0
  end

  def average_surprise
    votes.average(:surprise).round(3) if votes.count != 0
  end

  def average_total
    if votes.count != 0
      ((votes.sum(:presentation) + votes.sum(:content) + votes.sum(:surprise)) / votes.count.to_f).round(3)
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
    current_lightning_talk = LightningTalk.currents.first
    if current_lightning_talk
      where(lightning_talk_id: current_lightning_talk.id)
    else
      []
    end
  end
end
