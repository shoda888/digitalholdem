class Hole < ApplicationRecord
  has_many :cards, :as => :cardable
  belongs_to :player
  include AASM

  aasm do
    state :stay, :initial => true
    state :fold

    event :drop do
      transitions :from => :stay, :to => :fold
    end
  end
end
