class Card < ApplicationRecord

  after_initialize do
    $date_mark = Time.now + 259200
  end
  
  validates :original_text, :translated_text, :review_date, presence: true

  validate :origin_notequal_translation

  def origin_notequal_translation
    if original_text.casecmp(translated_text) == 0
      errors.add(:original_text)
    end
  end

end
