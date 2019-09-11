class PlaylistsController < ApplicationController
  def index
    @playlists = current_user.playlists
    @new_playlist = Playlist.new
  end

  def select
    current_user.current_playlist = params[:id]
    current_user.save
    redirect_to root_path
  end

  def create
    @playlists = current_user.playlists
    @new_playlist = Playlist.new(playlist_params)
    @new_playlist.user = current_user
    if @new_playlist.save
      current_user.current_playlist = @new_playlist.id
      current_user.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
