namespace :demonight do
  desc "Closes all voting demonights"
  task close: :environment do
    DemoNight.voting.update_all status: "closed"
  end
end
