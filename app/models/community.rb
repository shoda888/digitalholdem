class Community < ApplicationRecord
  has_many :cards, :as => :cardable
end
