class Community < ApplicationRecord
  has_many :cards, :as => :cardable
  belongs_to :game
  include AASM

  aasm do
    state :preflop, :initial => true
    state :flop
    state :turn
    state :river
    state :finished

    event :to_flop do
      transitions :from => :preflop, :to => :flop
    end

    event :to_turn do
      transitions :from => :flop, :to => :turn
    end

    event :to_river do
      transitions :from => :turn, :to => :river
    end

    event :finish do
      transitions :from => :preflop, :to => :finished
      transitions :from => :flop, :to => :finished
      transitions :from => :turn, :to => :finished
      transitions :from => :river, :to => :finished
    end
  end
end
