class ImportPlaylistsController < ApplicationController
  def index
  end

  def show
    playlist_id = params[:playlist_id]
    access_token = params[:access_token]
    url = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"
    playlist_data = JSON.parse(open(url, "Authorization" => "Bearer #{access_token}").read)
    @songs = playlist_data["items"]

  rescue OpenURI::HTTPError => e
    flash.notice = "No playlist was selected, please try again"
    redirect_to imports_path
  end

  def create
    if params[:songs].nil?
      redirect_to root_path
    else
      data = params[:songs]
      @songs = data.map { |song| JSON.parse(song) }
      playlist = Playlist.find(current_user.current_playlist)
      # raise
      @songs.each do |song_data|
        artist = Artist.find_or_create_by(name: song_data["artist"])
        song = Song.find_by(title: song_data["name"], artist: artist)

        song = Song.create(title: song_data["name"], artist: artist, album_url: song_data["url"]) if song.nil?

        Practice.create(playlist: playlist, song: song)
      end
      flash.notice = "You Imported #{@songs.count} Songs into #{playlist.name}"
      redirect_to :root
    end
  rescue JSON::ParserError => e
    flash.notice = "Sorry something went wrong, please try again"
    redirect_to :root
  end
end
