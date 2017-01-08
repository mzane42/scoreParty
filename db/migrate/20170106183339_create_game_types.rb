class CreateGameTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :game_types do |t|
      t.string :name
      t.string :url_img

      t.timestamps
    end
  end
end
