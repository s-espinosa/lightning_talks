namespace :demonight do
  desc "Nightly closes all open demonights"
  task close: :environment do
    DemoNight.update_all status: "closed"
  end
end
