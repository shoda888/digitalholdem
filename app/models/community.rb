class Community < ApplicationRecord
  include AasmCommunity
  has_many :cards, :as => :cardable
  has_many :holes
  belongs_to :game
end
