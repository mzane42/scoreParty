# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
  GameType.create(name: "Fifa", url_img: "https://s3.eu-west-2.amazonaws.com/score-party/Fifa.jpg"
  GameType.create(name: "Hearthstone", url_img: "https://s3.eu-west-2.amazonaws.com/score-party/hearthstone.jpg"
  GameType.create(name: "Street Fighter", url_img: "https://s3.eu-west-2.amazonaws.com/score-party/Street_Fighter.png"
  GameType.create(name: "Heroes of the Storm", url_img: "https://s3.eu-west-2.amazonaws.com/score-party/HeroesOfTheStorm.jpg"
=end
games_name = [
    [ 'Fifa', 'https://s3.eu-west-2.amazonaws.com/score-party/Fifa.jpg' ],
    [ 'Hearthstone', 'https://s3.eu-west-2.amazonaws.com/score-party/hearthstone.jpg' ],
    [ 'Street Fighter', 'https://s3.eu-west-2.amazonaws.com/score-party/Street_Fighter.png' ],
    [ 'Heroes of the Storm', 'https://s3.eu-west-2.amazonaws.com/score-party/HeroesOfTheStorm.jpg' ]
]
games_name.each do |name, url_img|
  GameType.create( name: name, url_img: url_img )
end
