# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

game = Game.create(:name => "テキサスホールデム")

Player.create(:name => "admin", :password => 'password', :game_id => game.id, :role => 1)
2.times do |no|
  Player.create(:name => "player#{no}", :password => 'password', :game_id => game.id, :role => 3)
end

# 10.times do |no|
#   community = game.communities.create(id: (no + 1) * 10)#コミュニティー作成
#
#   #コミュニティカード作成 #指定
#   case no
#   when 0 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 1 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 2 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 3 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 4 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 5 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 6 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 7 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 8 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   when 9 then
#     community.cards.create(suit:'s', number:1)
#     community.cards.create(suit:'c', number:7)
#     community.cards.create(suit:'s', number:3)
#     community.cards.create(suit:'c', number:9)
#     community.cards.create(suit:'s', number:5)
#   end
# end
