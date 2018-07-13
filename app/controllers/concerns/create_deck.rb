module CreateDeck
  extend ActiveSupport::Concern

  # メソッド
  def build
    @cards = []
    for s in ['s','h', 'd', 'c'] do
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

  def drawCard(num)
    if num.class == Integer
      @cards.pop(num)
    else
      @total_draw = []
      num.each do |n|
        draw = @cards.select{|card| card.suit == n[0] && card.number == n[1]}
        @cards.reject!{|card| card == draw[0]}
        @total_draw << draw[0]
      end
      @total_draw
    end
  end

end

class Tranp
  attr_accessor :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end
end
