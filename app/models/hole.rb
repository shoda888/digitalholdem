class Hole < ApplicationRecord
  has_many :cards, :as => :cardable
  belongs_to :player
end
