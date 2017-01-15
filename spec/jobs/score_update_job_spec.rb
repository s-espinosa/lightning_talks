require 'rails_helper'

RSpec.describe ScoreUpdateJob, type: :job do
  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {ScoreUpdateJob.perform_later}.to have_enqueued_job(ScoreUpdateJob)
  end

  it "matches with enqueued job" do
  projects = create_list(:project, 2)
  ActiveJob::Base.queue_adapter = :test
  expect {
    ScoreUpdateJob.perform_later(projects)
  }.to have_enqueued_job.with(projects)
end
end
