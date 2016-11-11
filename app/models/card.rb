class Card < ApplicationRecord
  after_initialize do
    $date_mark = Time.now + 259_200
  end

  validates :original_text, :translated_text, :review_date, presence: true
  validate :origin_notequal_translation

  def origin_notequal_translation
    original = original_text.mb_chars.upcase
    translated = translated_text.mb_chars.upcase
    if original.casecmp(translated) == 0
    errors.add(:original_text)
    end
  end
end
