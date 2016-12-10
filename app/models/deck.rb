class Deck < ApplicationRecord
belongs_to :user
has_many :cards, dependent: :destroy
scope :belongs_to_current_user, lambda {|current_user| where(user_id: current_user.id) }
end
