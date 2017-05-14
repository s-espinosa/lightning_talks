namespace :demonight do
  desc "Closes all open demonights"
  task close: :environment do
    DemoNight.update_all status: "closed"
  end
end
