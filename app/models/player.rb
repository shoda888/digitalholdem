class Player < ApplicationRecord
  belongs_to :game, optional: true
  has_many :holes

  validates :name, presence: true
  validates :password, presence: true
end
