# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

game = Game.create(:name => "テキサスホールデム")

5.times do |no|
  Player.create(:name => "player#{no}", :password => 'password', :game_id => game.id)
end
