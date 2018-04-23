class HomesController < ApplicationController
  include CreateDeck

  def index
    @player = Player.create #プレイヤー一人作成
    @community = Community.create #コミュニティー作成
    @cards = shuffle(build) #シャッフルされた52枚のカード

    pp @cards.length
    @player_cards = drawCard(2) #ホールカード作成
    @player.cards.create(suit:@player_cards[0].suit, number:@player_cards[0].number)
    @player.cards.create(suit:@player_cards[1].suit, number:@player_cards[1].number)

    # @player_cards.each do |c|
    #   @player.cards.create(suit:c.suit, number:c.number)
    # end
    pp @cards.length
    @community_cards = drawCard(5) #コミュニティカード作成
    @community.cards.create(suit:@community_cards[0].suit, number:@community_cards[0].number)
    @community.cards.create(suit:@community_cards[1].suit, number:@community_cards[1].number)
    @community.cards.create(suit:@community_cards[2].suit, number:@community_cards[2].number)
    @community.cards.create(suit:@community_cards[3].suit, number:@community_cards[3].number)
    @community.cards.create(suit:@community_cards[4].suit, number:@community_cards[4].number)

    # @community_cards.each do |c|
    #   @community.cards.create(suit:c.suit, number:c.number)
    # end

  end
end
