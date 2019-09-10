class PlaylistsController < ApplicationController
  def index
    @playlists = current_user.playlists
  end

  def select
    current_user.current_playlist = params[:id]
    current_user.save
    redirect_to root_path
  end
end
