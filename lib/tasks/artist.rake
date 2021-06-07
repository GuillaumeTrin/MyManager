namespace :artist do
  desc "Get all stats from Facebook"
  task update_all: :environment do
    UpdateAllDataArtists.call
  end

end
