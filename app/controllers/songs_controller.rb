class SongsController < ApplicationController
  def create
    raise
  end

  def song_search
    search_term = params[:query]
    @songs = []
    response = open("https://itunes.apple.com/search?term=#{search_term}&entity=musicTrack&limit=5").read
    json = JSON.parse(response)
    json['results'].each do |song|
      @songs << { title: song['trackName'], artist: song['artistName'], album_url: song['collectionViewUrl'] }
    end
    render '/pages/home'
  end
end
