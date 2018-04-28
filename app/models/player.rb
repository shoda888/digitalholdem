class Player < ApplicationRecord
  has_many :cards, :as => :cardable
  belongs_to :game, optional: true

  validates :name, presence: true
  validates :password, presence: true
end
