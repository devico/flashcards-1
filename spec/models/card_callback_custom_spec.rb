require 'rails_helper'
describe Card do 
  subject { Card.new }
  context 'when created' do
    it 'updates review date with 3 days from now on save' do
      subject.review_date = nil
      subject.run_callbacks :create
      expect(subject.review_date.strftime('%d-%m-%Y')).to eq(3.days.since.strftime('%d-%m-%Y'))
    end
  end
  context 'before saved' do
    it 'shall return false if texts are equal regardless registr' do
      expect(Card.new(original_text: 'Test', translated_text: 'tEst')).not_to be_valid
    end
  end
end
