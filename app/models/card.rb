class Card < ApplicationRecord
  belongs_to :deck

  # def initialize(suit, number)
  #   @suit = suit
  #   @number = number
  # end

  def show
    puts "#{@suit}#{@number}"
  end

end
