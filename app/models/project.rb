class Project < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
end
