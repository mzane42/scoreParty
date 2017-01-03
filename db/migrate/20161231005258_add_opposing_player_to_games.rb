class AddOpposingPlayerToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :opposing_player, :string
  end
end
