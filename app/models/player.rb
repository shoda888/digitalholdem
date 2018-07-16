class Player < ApplicationRecord
  belongs_to :game, optional: true
  has_many :holes

  validates :name, presence: true
  validates :password, presence: true

  enum role: { admin: 1, participants: 2, tester: 3 }
  # admin: 実験管理者
  # participants: サクラ
  # tester: 被験者
end
