class RemovePlayerHomeIdFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :player_home_id, :integer
  end
end
