class Deck < ApplicationRecord
  has_many :cards



  def self.build
    deck = Deck.create!
    @cards = []
    for s in ["♠","♥", "♦", "♣"] do
      for v in 1..13 do
        @cards << deck.cards.create(suit:s, number:v)
      end
    end
  end

  def show
    @cards.each do |card|
      card.show #Cardクラスのshowを呼び出し
    end
  end

  def shuffle
    cards_length = (@cards.count) -1
    cards_length.step(1,-1) do |i|
      r = rand(i)
      @cards[i] , @cards[r] = @cards[r], @cards[i]
    end
  end
  def drawCard
    @cards.pop
  end
end
