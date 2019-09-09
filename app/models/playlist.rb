class Playlist < ApplicationRecord
  belongs_to :user
  has_many :practices, dependent: :destroy
  validates :name, presence: true
end
