require 'rails_helper'
describe Card do
  context 'before saved' do
    it 'shall return false if texts are equal regardless registr' do
     expect(Card.new(original_text: 'Test', translated_text: 'tEst')).not_to be_valid
    end
  end
end
