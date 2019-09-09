class User < ApplicationRecord
  has_many :playlists
  has_many :practices, through: :playlists
  has_many :songs, through: :practices
  # need to figure out a way to get songs through playlists, then practices, then songs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :photo, PhotoUploader
end
