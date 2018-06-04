module HandJudgement
  extend ActiveSupport::Concern

  def hand_judge(targetcards)
    if isRoyal_straight_flush(targetcards)
      return 'RoyalStraightFlush'
    elsif isStraight_flush(targetcards)
      return 'StraightFlash'
    elsif @highcard = isSame_number(targetcards, 4)
      return select_highcard + 'FourCards'
    elsif @highcard = isFull_house(targetcards)
      return select_highcard + 'FullHouse'
    elsif @highcard = isFlush(targetcards)
      return select_highcard + 'Flash'
    elsif @highcard = isStraight(targetcards)
      return select_highcard + 'Straight'
    elsif @highcard = isSame_number(targetcards, 3)
      return select_highcard + 'ThreeCards'
    elsif @highcard = isTwo_pairs(targetcards)
      return select_highcard + 'TwoPairs'
    elsif @highcard = isSame_number(targetcards, 2)
      return select_highcard + 'OnePair'
    else
      return highHand(targetcards) + 'Hand'
    end
  end

  private
  def highHand(targetcards)
    targetcards.each do |card|
      @highcard = 1 if card.number == 1
    end
    @highcard = targetcards.max {|a, b| a.number <=> b.number }.number
    return select_highcard
  end
  def isFlush(targetcards)
  	suits = { 's':0, 'h':0, 'd':0, 'c':0 }
    targetcards.each do |card|
      suits[card.suit.to_sym] += 1
    end
    suits.each do |key, value|
      if value >= 5
        same_number_cards = targetcards.select{ |card| card.suit == key.to_s }
        max_number = same_number_cards.max {|a, b| a.number <=> b.number }.number
        min_number = same_number_cards.min {|a, b| a.number <=> b.number }.number
        if min_number == 1
          return 1
        else
          return max_number
        end
      end
    end
	  return false
  end

  def isSame_number(targetcards, sameCount)
	  numbers = { 1=> 0, 2=> 0, 3=> 0, 4=> 0, 5=> 0, 6=> 0, 7=> 0, 8=> 0, 9=> 0, 10=> 0, 11=> 0, 12=> 0, 13=> 0 }
    targetcards.each do |card|
      numbers[card.number] += 1
    end
    numbers.each { |key, value| if value >= sameCount then return key end }
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
    if same_count[2] >= 2
      if numbers[1] == 2
        return 1
      else
        return numbers.select{|k, v| v == 2 }.keys.max
      end
    end
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
    if (same_count[2] >= 1 && same_count[3] >= 1) || same_count[3] >= 2
      if numbers[1] == 3
        return 1
      else
        return numbers.select{|k, v| v == 3 }.keys.max
      end
    end
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
  			return i + 5
  		end
  	end
  	#10から始まるストレートのみ1（エース）が含まれるため別で判定
  	if numbers[10]>=1 && numbers[11]>=1 && numbers[12]>=1 && numbers[13]>=1 && numbers[1]>=1
  		return 1
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
  def select_highcard
    case @highcard
    when 1 then return 'A High '
    when 2 then return '2 High '
    when 3 then return '3 High '
    when 4 then return '4 High '
    when 5 then return '5 High '
    when 6 then return '6 High '
    when 7 then return '7 High '
    when 8 then return '8 High '
    when 9 then return '9 High '
    when 10 then return '10 High '
    when 11 then return 'J High '
    when 12 then return 'Q High '
    when 13 then return 'K High '
    end
  end
end
