class Player < ApplicationRecord
  has_many :cards, :as => :cardable

end
