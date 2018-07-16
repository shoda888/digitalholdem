class Player < ApplicationRecord
  belongs_to :game, optional: true
  has_many :holes

  validates :name, presence: true
  validates :password, presence: true

  enum role: { admin: 1, normal: 2, dealer: 3 }
  # admin: 実験管理者
  # dealer: サクラ
  # normal: 被験者
end
