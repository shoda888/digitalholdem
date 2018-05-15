class Hole < ApplicationRecord
  has_many :cards, :as => :cardable
  belongs_to :player
  enum hand: {Highhand:0, OnePair:100, TwoPairs:200, ThreeCards:300, Straight:400, Flash:500, FullHouse:600, FourCards:700, StraightFlash:800, RoyalStraightFlush:900}
  include AASM

  aasm do
    state :stay, :initial => true
    state :fold

    event :drop do
      transitions :from => :stay, :to => :fold
    end
  end
end
