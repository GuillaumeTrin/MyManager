require "open-uri"

Post.destroy_all
Album.destroy_all
Artist.destroy_all
User.destroy_all


user_1 = User.create!(first_name: "Guillaume", last_name: "Trin", email: "guillaume.trin@gmail.com", password: "totototo")

artist_ephemeris = Artist.create!(name: "Nicolas", id_facebook: "1234", user: user_1)
album_moobbow = Album.create!(name: "Moonbow", out_at: "2021-06-15", artist: artist_ephemeris)
post_announce_album = Post.create!(title: "Announce Album", content: "Our next on Sahman Records, is an impressive collaboration between our home artist Ephemeris and the talented producer Waveorm from Grece. This epic trancer will float you gently to a pure trippy oasis ! Available the 12.10.20 !", artist: artist_ephemeris, album: album_moobbow)

