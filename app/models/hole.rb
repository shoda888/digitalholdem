class Hole < ApplicationRecord
  has_many :cards, :as => :cardable
  belongs_to :player
  belongs_to :community
  enum hand: {Highhand:0,
              '2 High Hand': 5, '3 High Hand': 10, '4 High Hand': 15, '5 High Hand': 20, '6 High Hand': 25,
              '7 High Hand': 30, '8 High Hand': 35, '9 High Hand': 40, '10 High Hand': 45, 'J High Hand': 50,
              'Q High Hand': 55, 'K High Hand': 60, 'A High Hand': 65,
               OnePair:100,
              '2 High OnePair': 105, '3 High OnePair': 110, '4 High OnePair': 115, '5 High OnePair': 120, '6 High OnePair': 125,
              '7 High OnePair': 130, '8 High OnePair': 135, '9 High OnePair': 140, '10 High OnePair': 145, 'J High OnePair': 150,
              'Q High OnePair': 155, 'K High OnePair': 160, 'A High OnePair': 165,
              TwoPairs:200,
              '2 High TwoPairs': 205, '3 High TwoPairs': 210, '4 High TwoPairs': 215, '5 High TwoPairs': 220, '6 High TwoPairs': 225,
              '7 High TwoPairs': 230, '8 High TwoPairs': 235, '9 High TwoPairs': 240, '10 High TwoPairs': 245, 'J High TwoPairs': 250,
              'Q High TwoPairs': 255, 'K High TwoPairs': 260, 'A High TwoPairs': 265,
              ThreeCards:300,
              '2 High ThreeCards': 305, '3 High ThreeCards': 310, '4 High ThreeCards': 315, '5 High ThreeCards': 320, '6 High ThreeCards': 325,
              '7 High ThreeCards': 330, '8 High ThreeCards': 335, '9 High ThreeCards': 340, '10 High ThreeCards': 345, 'J High ThreeCards': 350,
              'Q High ThreeCards': 355, 'K High ThreeCards': 360, 'A High ThreeCards': 365,
              Straight:400,
              '2 High Straight': 405, '3 High Straight': 410, '4 High Straight': 415, '5 High Straight': 420, '6 High Straight': 425,
              '7 High Straight': 430, '8 High Straight': 435, '9 High Straight': 440, '10 High Straight': 445, 'J High Straight': 450,
              'Q High Straight': 455, 'K High Straight': 460, 'A High Straight': 465,
              Flash:500,
              '2 High Flash': 505, '3 High Flash': 510, '4 High Flash': 515, '5 High Flash': 520, '6 High Flash': 525,
              '7 High Flash': 530, '8 High Flash': 535, '9 High Flash': 540, '10 High Flash': 545, 'J High Flash': 550,
              'Q High Flash': 555, 'K High Flash': 560, 'A High Flash': 565,
              FullHouse:600,
              '2 High FullHouse': 605, '3 High FullHouse': 610, '4 High FullHouse': 615, '5 High FullHouse': 620, '6 High FullHouse': 625,
              '7 High FullHouse': 630, '8 High FullHouse': 635, '9 High FullHouse': 640, '10 High FullHouse': 645, 'J High FullHouse': 650,
              'Q High FullHouse': 655, 'K High FullHouse': 660, 'A High FullHouse': 665,
              FourCards:700,
              '2 High FourCards': 705, '3 High FourCards': 710, '4 High FourCards': 715, '5 High FourCards': 720, '6 High FourCards': 725,
              '7 High FourCards': 730, '8 High FourCards': 735, '9 High FourCards': 740, '10 High FourCards': 745, 'J High FourCards': 750,
              'Q High FourCards': 755, 'K High FourCards': 760, 'A High FourCards': 765,
              StraightFlash:800, RoyalStraightFlush:900}
  include AASM

  aasm do
    state :stay, :initial => true
    state :fold

    event :drop do
      transitions :from => :stay, :to => :fold
    end
  end
end
