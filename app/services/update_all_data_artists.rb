class UpdateAllDataArtists < BaseService
  def call
    artists = Artist.all
    artists.find_each do |artist|
      UpdateOneArtistJob.perform_later(artist)
    end
  end
end
