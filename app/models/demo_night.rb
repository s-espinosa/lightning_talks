class DemoNight < ApplicationRecord
  has_many :projects
  has_many :votes, through: :projects

  def self.current
    find_by(active: true)
  end
end
