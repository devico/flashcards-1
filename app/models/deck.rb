class Deck < ApplicationRecord
belongs_to :user
scope :belongs_to_current_user, lambda {|current_user| where(user_id: current_user.id) }
end
