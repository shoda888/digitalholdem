class Player < ApplicationRecord
  has_one :hole

  def initialize
    @hands = []
  end
  def draw(deck)
    @hands.push(deck.drawCard)
  end
  def showHands
    puts "あなたの手札"
    @hands.each do |hand|
      hand.show
    end
  end
end
