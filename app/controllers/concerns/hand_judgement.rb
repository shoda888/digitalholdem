module HandJudgement
  extend ActiveSupport::Concern

  def hand_judge(targetcards)
    # if isRoyal_straight_flush(targetcards)
    #   return 'RoyalStraightFlush'
    # elsif isStraight_flush(targetcards)
    #   return 'StraightFlash'
    if isSame_number(targetcards, 4)
      return 'FourCards'
    # elsif isFull_house(targetcards)
    #   return 'FullHouse'
    elsif isFlush(targetcards)
      return 'Flash'
    # elsif isStraight(targetcards)
    #   return 'Straight'
    elsif isSame_number(targetcards, 3)
      return 'ThreeCards'
    # elsif isTwo_pairs(targetcards)
    #   return 'TwoPairs'
    elsif isSame_number(targetcards, 2)
      return 'OnePair'
    else
      return 'Highhand'
    end
  end

  private
  def isFlush(targetcards)
  	suits = { 's':0, 'h':0, 'd':0, 'c':0 }
    targetcards.each do |card|
      suits[card.suit.to_sym] += 1
    end
    suits.each_value { |value| if value >= 5 then return true end }
	  return false
  end

  def isSame_number(targetcards, sameCount)
	  numbers = { 1=> 0, 2=> 0, 3=> 0, 4=> 0, 5=> 0, 6=> 0, 7=> 0, 8=> 0, 9=> 0, 10=> 0, 11=> 0, 12=> 0, 13=> 0 }
    targetcards.each do |card|
      numbers[card.number] += 1
    end
    numbers.each_value { |value| if value >= sameCount then return true end }
	  return false
  end
end
