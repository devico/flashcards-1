require 'rails_helper'
describe CheckTranslation do 
  before do
    @test_card = FactoryGirl.create(:card, original_text: 'test', translated_text: 'test_translation')
  end
  it 'if words equal notice shall return success message' do
    interactor = CheckTranslation.call(users: 'test', card_id: @test_card.id)
    expect(interactor.notice).to eq('Все верно! Для закрепления повторим через три дня')
  end
    it 'if words equal card shall be updated with new date' do
    interactor = CheckTranslation.call(users: 'test', card_id: @test_card.id)
    expect(@test_card.review_date.strftime('%d-%m-%Y')).to eq(3.days.since.strftime('%d-%m-%Y'))
  end
  it 'if words not equal notice shall return error message' do
    interactor = CheckTranslation.call(users: 'test1', card_id: @test_card.id)
    expect(interactor.notice).to eq('Ошибка, неправильный перевод')
  end
end 
