module CreateDeck
  extend ActiveSupport::Concern

  # メソッド
  def build
    @cards = []
    for s in ["♠","♥", "♦", "♣"] do
      for v in 1..13 do
        @cards << Tranp.new(s, v)
      end
    end
    @cards
  end

  def shuffle(cards)
    cards_length = (cards.count) -1
    cards_length.step(1,-1) do |i|
      r = rand(i)
      cards[i] , cards[r] = cards[r], cards[i]
    end
    cards
  end

  def drawCard(number)
    @cards.pop(number)
  end

end

class Tranp
  attr_accessor :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end
end
