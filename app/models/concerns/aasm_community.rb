module AasmCommunity
  extend ActiveSupport::Concern
  included do
    include AASM
    include AasmHistory
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
        transitions :from => :preflop, :to => :showdown
        transitions :from => :flop, :to => :showdown
        transitions :from => :turn, :to => :showdown
        transitions :from => :river, :to => :showdown
      end

      event :finish do
        transitions :from => :showdown, :to => :finished
      end
    end
  end
end
