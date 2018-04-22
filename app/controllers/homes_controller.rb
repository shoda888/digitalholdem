class HomesController < ApplicationController
  include CreateDeck

  def index
    @player = Player.new
    @cards = shuffle(build)

    @player_cards = drawCard(2)

    # @player.cards.create(suit:@player_cards[0].suit, number:@player_cards[0].number)
    # @player.cards.create(suit:@player_cards[1].suit, number:@player_cards[1].number)

    
    pp @player_cards[0].suit
  end
end
