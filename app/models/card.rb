class Card < ApplicationRecord

  scope :review_date_earlier_or_equal, lambda { where("review_date <= ?", Date.today) }
  scope :random, -> {order('RANDOM()').limit(1) }
  before_create :set_review_date

  def self.pick_rand
    order('RANDOM()').first
  end
  
  def set_review_date
    self.review_date = 3.days.since
  end

  validates :original_text, :translated_text, presence: true
  validate :origin_notequal_translation

  def origin_notequal_translation
    original = original_text.mb_chars.upcase
    translated = translated_text.mb_chars.upcase
    if original.casecmp(translated) == 0
      errors.add(:original_text)
    end
  end
end
