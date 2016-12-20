class User < ApplicationRecord
  has_many :submitted_projects, class_name: "Project",
                                foreign_key: "user_id"
  has_many :votes
  has_many :voted_projects, through: :votes, source: :project

  enum role: [:default, :admin]

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid      = auth["uid"]
      user.name     = auth["info"]["name"]
      user.email    = auth["info"]["email"]
      user.nickname = auth["info"]["nickname"]
      user.github   = auth["info"]["urls"]["GitHub"]
    end
  end
end
