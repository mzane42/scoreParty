class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :player_home_id
      t.integer :player_away_id
      t.boolean :verified, :default => false
      t.integer :score_home
      t.integer :score_away

      t.timestamps
    end
  end
end
