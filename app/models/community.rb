class Community < ApplicationRecord
  has_many :cards, :as => :cardable
  has_many :holes
  belongs_to :game
  include AasmHistory
  include AASM

  aasm do
    state :preflop, :initial => true
    state :flop
    state :turn
    state :river
    state :finished
    state :showdown

    event :to_flop do
      transitions :from => :preflop, :to => :flop
    end

    event :to_turn do
      transitions :from => :flop, :to => :turn
    end

    event :to_river do
      transitions :from => :turn, :to => :river
    end

    event :open do
      transitions :from => :river, :to => :showdown
    end

    event :finish do
      transitions :from => :preflop, :to => :finished
      transitions :from => :flop, :to => :finished
      transitions :from => :turn, :to => :finished
      transitions :from => :river, :to => :finished
      transitions :from => :showdown, :to => :finished
    end
  end
end
