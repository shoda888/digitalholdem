module AasmCommunity
  extend ActiveSupport::Concern
  included do
    include AASM
    include AasmHistory
    aasm do
      state :flop, :initial => true
      state :river
      state :finished
      state :showdown

      event :to_river do
        transitions :from => :flop, :to => :river
      end

      event :open do
        transitions :from => :river, :to => :showdown
      end

      event :finish do
        transitions :from => :showdown, :to => :finished
      end
    end
  end
end
