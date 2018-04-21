class Card
  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  def show
    puts "#{@suit}#{@number}"
  end
end

class Deck
   def initialize
     @cards = []
     build
   end

   def build
     for s in ["♠","♥", "♦", "♣"] do
       for v in 1..13 do
         @cards << Card.new(s,v)
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

class Player
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

deck = Deck.new
player = Player.new
deck.shuffle
player.draw(deck)
player.showHands
