class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :user_id, uniqueness: { scope: :project_id }
  scope :user_votes, -> (user_id) { where(user_id: user_id) }
end
