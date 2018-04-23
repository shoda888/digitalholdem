class HomesController < ApplicationController
  include CreateDeck

  def index
    @player = Player.create #プレイヤー一人作成
    @community = Community.create #コミュニティー作成
    @cards = shuffle(build) #シャッフルされた52枚のカード

    @player_cards = drawCard(2) #ホールカード作成
    @player_cards.each do |c|
      @player.cards.create(suit:c.suit, number:c.number)
    end

    @community_cards = drawCard(5) #コミュニティカード作成
    @community_cards.each do |c|
      @community.cards.create(suit:c.suit, number:c.number)
    end
    
  end
end
