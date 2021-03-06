class Card < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :deck
  scope :review_date_earlier_or_equal, lambda { where("review_date <= ?", Time.current) }
  scope :from_active_deck, lambda {|current_user| where(deck_id: current_user.deck_id) }
  scope :belongs_to_current_user, lambda {|current_user| where(user_id: current_user.id) }
  scope :random, -> {order('RANDOM()').limit(1) }
  before_create :set_review_date_counter

  def self.pick_rand
    order('RANDOM()').first
  end
  
  def set_review_date_counter
    self.review_date = Time.current
    self.correct = 0
    self.wrong = 0
  end

  validates :original_text, :translated_text, :deck_id, presence: true
  validate :origin_notequal_translation

  def origin_notequal_translation
    original = original_text.mb_chars.upcase
    translated = translated_text.mb_chars.upcase
    if original.casecmp(translated) == 0
      errors.add(:original_text)
    end
  end
end
