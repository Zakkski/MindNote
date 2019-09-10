
puts "Clearing Database..."
Session.destroy_all
Playlist.destroy_all
Song.destroy_all
Artist.destroy_all
User.destroy_all

puts "Creating user..."
u = User.new(email: "user@email.com", name: "user", password: "password", photo: "image/upload/v1559149365/dxf4dzbrhukthuxjkhnx.jpg")
u.save!

puts "Creating Playlists"
p = Playlist.create(name: "Main Playlist", user: u)
p2 = Playlist.create(name: "Second Playlist", user: u)
u.update(current_playlist: p.id)

puts "Creating artist..."
a = Artist.new(name: "Relient K")
a.save!
queen = Artist.new(name: "Queen")
elo = Artist.new(name: "Electric Light Orchestra")
elo.save!
st=Artist.new(name: "Shania Twain")
st.save!
celine=Artist.new(name: "Celine Dion")
celine.save!
puts "5 artists created"


puts "Creating Songs..."
s = Song.new(title: "Forget and Not Slow Down", artist: a, album_url: "https://is3-ssl.mzstatic.com/image/thumb/Music/v4/77/bb/89/77bb8908-a158-cf32-66ab-e27d03931759/source/600x600bb.jpg")
s.save!
s2 = Song.new(title: "Another One Bites the Dust", artist: queen, album_url: "https://is5-ssl.mzstatic.com/image/thumb/Music118/v4/7f/6f/36/7f6f3680-6bfe-3f13-aecb-99aa6a87848b/source/600x600bb.jpg")
s2.save!
s3 = Song.new(title: "Don't Bring Me Down", artist: elo, album_url: "https://is1-ssl.mzstatic.com/image/thumb/Music2/v4/ec/d7/88/ecd78889-af4b-bfed-5800-e6c7dd4ca19b/source/600x600bb.jpg")
s3.save!
s4 = Song.new(title: "Livin' Thing", artist: elo, album_url: "https://is1-ssl.mzstatic.com/image/thumb/Music2/v4/ec/d7/88/ecd78889-af4b-bfed-5800-e6c7dd4ca19b/source/600x600bb.jpg")
s4.save!
s5 = Song.new(title: "You're Still the One", artist: st, album_url: "https://is2-ssl.mzstatic.com/image/thumb/Music62/v4/51/e6/03/51e603a2-270b-6c98-6ba7-a64623163bec/source/600x600bb.jpg")
s5.save!
s6 = Song.new(title: "The Power of Love", artist: celine, album_url: "https://is1-ssl.mzstatic.com/image/thumb/Music/v4/13/f8/2c/13f82c2e-dd56-0362-01d1-9aef0664976c/source/600x600bb.jpg")

puts " 6 songs created"


puts "Creating Practices..."
prac = Practice.create!(playlist: p, song: s, interval: 1, active: true)
prac2 = Practice.create!(playlist: p, song: s2, interval: 1, active: true)
prac3 = Practice.create!(playlist: p, song: s3, interval: 1)
prac4 = Practice.create!(playlist: p2, song: s4, interval: 1, active: true)
prac5 = Practice.create!(playlist: p2, song: s5, interval: 1, active: true)
prac6 = Practice.create!(playlist: p2, song: s6, interval: 1)
puts "6 practices created"

puts "Creating Sessions"
sess = Session.create!(practice: prac, time: 1409, grade: 3)
sess2 = Session.create!(practice: prac2, time: 1409, grade: 3)
sess4 = Session.create!(practice: prac4, time: 1409, grade: 3)
sess5 = Session.create!(practice: prac5, time: 1409, grade: 3)
Session.all.each { |session| session.update_attributes(created_at: 1.years.ago) }
puts "Seed complete!"
