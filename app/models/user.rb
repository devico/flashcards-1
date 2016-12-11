class User < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :email, uniqueness: true

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :decks, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
