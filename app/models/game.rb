class Game < ApplicationRecord
  validates_presence_of :opposing_player
  validates_presence_of :score_home
  validates_presence_of :score_away
  belongs_to :user
  belongs_to :game_type
end
