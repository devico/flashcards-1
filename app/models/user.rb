class User < ApplicationRecord
  has_many :cards, dependent: :destroy
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :email, uniqueness: true
end
