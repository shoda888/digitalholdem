module HandJudgement
  extend ActiveSupport::Concern

  def hand_judge(targetcards)
    if isRoyal_straight_flush(targetcards)
      return 'RoyalStraightFlush'
    elsif isStraight_flush(targetcards)
      return 'StraightFlash'
    elsif isFour_cards(targetcards)
      return 'FourCards'
    elsif isFull_house(targetcards)
      return 'FullHouse'
    elsif isFlush(targetcards)
      return 'Flash'
    elsif isStraight(targetcards)
      return 'Straight'
    elsif isThree_cards(targetcards)
      return 'ThreeCards'
    elsif isTwo_pairs(targetcards)
      return 'TwoPairs'
    elsif isOne_pair(targetcards)
      return 'OnePair'
    else isHigh_hand(targetcards)
      return 'Highhand'
    end
  end

  private
  def isFlash(targetcards)

  end

end
