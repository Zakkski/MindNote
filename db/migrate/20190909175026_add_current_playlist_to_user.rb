class AddCurrentPlaylistToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_playlist, :integer
  end
end
