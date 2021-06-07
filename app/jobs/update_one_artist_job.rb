class UpdateOneArtistJob < ApplicationJob
  queue_as :default

  def perform(artist)
    # Do something later
    UpdateOneArtist.new(artist).call
  end
end
