class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :user_id, uniqueness: { scope: :project_id }
  
  after_create_commit { ScoreUpdateJob.perform_later DemoNight.top_five }
end
