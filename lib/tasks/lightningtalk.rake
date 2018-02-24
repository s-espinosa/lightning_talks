namespace :lightningtalk do
  desc "Closes all voting lightningtalks"
  task close: :environment do
    LightningTalk.voting.update_all status: "closed"
  end
end
