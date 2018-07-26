class Community < ApplicationRecord
  include AasmCommunity
  has_many :cards, :as => :cardable
  has_many :holes
  has_one :review
  belongs_to :game
end
