class UpdateAllDataArtists < BaseService
  def call
    artists = Artist.all
    artists.find_each do |artist|
      UpdateOneArtistJob.perform_now(artist)
    end
  end
end
