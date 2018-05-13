class Game < ApplicationRecord
  has_many :communities
  has_many :players
  validates :name, presence: true
end
