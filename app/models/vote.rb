class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :user_id, uniqueness: { scope: :project_id }

  after_commit { ScoreUpdateJob.perform_later LightningTalk.current.sorted_projects }
end
