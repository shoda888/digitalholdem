module HandJudgement
  extend ActiveSupport::Concern

  def hand_judge(targetcards)
    if isRoyal_straight_flush(targetcards)
      return 'RoyalStraightFlush'
    elsif isStraight_flush(targetcards)
      return 'StraightFlash'
    elsif isSame_number(targetcards, 4)
      return 'FourCards'
    elsif isFull_house(targetcards)
      return 'FullHouse'
    elsif isFlush(targetcards)
      return 'Flash'
    elsif isStraight(targetcards)
      return 'Straight'
    elsif isSame_number(targetcards, 3)
      return 'ThreeCards'
    elsif isTwo_pairs(targetcards)
      return 'TwoPairs'
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
  def isTwo_pairs(targetcards)
    numbers = { 1=> 0, 2=> 0, 3=> 0, 4=> 0, 5=> 0, 6=> 0, 7=> 0, 8=> 0, 9=> 0, 10=> 0, 11=> 0, 12=> 0, 13=> 0 }
    targetcards.each do |card|
      numbers[card.number] += 1
    end
    same_count = { 0=> 0, 1=> 0, 2=> 0, 3=> 0, 4=> 0 }
    13.times do |i|
      same_count[numbers[i + 1]] += 1
    end
    return true if same_count[2] >= 2
    return false
  end
  def isFull_house(targetcards)
    numbers = { 1=> 0, 2=> 0, 3=> 0, 4=> 0, 5=> 0, 6=> 0, 7=> 0, 8=> 0, 9=> 0, 10=> 0, 11=> 0, 12=> 0, 13=> 0 }
    targetcards.each do |card|
      numbers[card.number] += 1
    end
    same_count = { 0=>0, 1=> 0, 2=> 0, 3=> 0, 4=> 0 }
    13.times do |i|
      same_count[numbers[i + 1]] += 1
    end
    return true if same_count[2] >= 1 && same_count[3] >= 1
    return true if same_count[3] >= 2
    return false
  end
  def isStraight(targetcards)
    numbers = { 1=> 0, 2=> 0, 3=> 0, 4=> 0, 5=> 0, 6=> 0, 7=> 0, 8=> 0, 9=> 0, 10=> 0, 11=> 0, 12=> 0, 13=> 0 }
    targetcards.each do |card|
      numbers[card.number] += 1
    end
  	#1から始まるストレート～9から始まるストレートを判定する
    9.times do |i|
  		if numbers[i+1]>=1 && numbers[i+2]>=1 && numbers[i+3]>=1 && numbers[i+4]>=1 && numbers[i+5]>=1
  			return true
  		end
  	end
  	#10から始まるストレートのみ1（エース）が含まれるため別で判定
  	if numbers[10]>=1 && numbers[11]>=1 && numbers[12]>=1 && numbers[13]>=1 && numbers[1]>=1
  		return true
  	end
  	return false
  end
  def isStraight_flush(targetcards)
    suits = { 's':[], 'h':[], 'd':[], 'c':[] }
    targetcards.each do |card|
      suits[card.suit.to_sym] << card
    end
    suits.each_value do |value|
      return true if value.length >= 5 && isStraight(value)
    end
  	return false
  end
  def isRoyal_straight_flush(targetcards)
  	cards = [];
    targetcards.each do |card|
      cards << card if card.number >= 10 || card.number == 1
    end
  	return true if isStraight_flush(cards)
  	return false
  end
end
