class AddDescriptionToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :description, :string
  end
end
