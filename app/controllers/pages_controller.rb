class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing
  def home
    unless current_user.playlists.present?
      p = Playlist.new(name: "Main Playlist", user: current_user)
      p.save
      current_user.current_playlist = p.id
      # current_user.Practices.each { |practice| practice.update(practice: p) }
    end
    @playlist = Playlist.find(current_user.current_playlist)
    @songs_due = Practice.urgent_songs(current_user.current_playlist)
    @first = @songs_due.first
  end

  def landing

  end
end
