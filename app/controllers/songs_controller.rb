class SongsController < ApplicationController
  def new
    @song = Song.new
  end

  def learn
    if params[:term]
      search_result = Song.search_by_title_artist(params[:term])

      search_as_array = search_result.to_a

      checked_array = search_as_array.select { |song| current_user.songs.include?(song) }

      @unlearned = checked_array.map { |song| Practice.where(song_id: song).first }

      @unlearned = current_user.practices.where(active: false) if params[:term].empty?

    else
      @unlearned = current_user.practices.where(active: false)
    end
  end

  def create
    if params[:radios].nil?
      redirect_to root_path
    else
      song_data = JSON.parse(params[:radios])
      artist = Artist.find_or_create_by(name: song_data["artistName"])
      album = song_data["artworkUrl100"]
      album.gsub!(/source\/*.*.jpg/, "source/600x600bb.jpg")

      song = Song.find_by(title: song_data["trackName"], artist: artist)

      song = Song.create(title: song_data["trackName"], artist: artist, album_url: album) if song.nil?

      practice = Practice.new(user: current_user, song: song)

      if practice.save
        flash.notice = "You added #{practice.song.title} to your list"
      else
        flash.notice = "This song is already in your list"
      end
      redirect_to :root
    end
  rescue JSON::ParserError => e
    flash.notice = "Sorry something went wrong, please try again"
    redirect_to :root
  end

  private

  def songs_params
    # don't know how to do this
    params.require(:song).permit(:title, :artist, :album_url)
  end
end
