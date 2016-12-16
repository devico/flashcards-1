require 'rails_helper'
describe CheckTranslation do 
  before do
    user = create(:user, email: 'user@rails.com', password: 'qwerty')
    deck = create(:deck, name: 'test', user_id: user.id)
    @test_card = FactoryGirl.create(:card, original_text: 'test', translated_text: 'test_translation', user_id: user.id, deck_id: deck.id)
  end
  it 'if words equal notice shall return success message' do
    interactor = CheckTranslation.call(users: 'test', card_id: @test_card.id)
    expect(interactor.notice).to eq('Все верно!')
  end
  it 'if words equal card shall be updated with new date' do
    CheckTranslation.call(users: 'test', card_id: @test_card.id)
    card = Card.find_by(id: @test_card.id)
    expect(card.review_date.strftime('%H-%d-%m-%Y')).to eq(12.hours.since.strftime('%H-%d-%m-%Y'))
  end
  it 'if words not equal 3 times date shall be reset' do
    CheckTranslation.call(users: 'test', card_id: @test_card.id)
    3.times do
      CheckTranslation.call(users: 'tester', card_id: @test_card.id)
    end
    card = Card.find_by(id: @test_card.id)
    expect(card.wrong).to eq(0)
    expect(card.review_date.strftime('%H-%d-%m-%Y')).to eq(Time.current.strftime('%H-%d-%m-%Y'))
  end
  it 'if words not equal notice shall return error message' do
    interactor = CheckTranslation.call(users: 'tester', card_id: @test_card.id)
    expect(interactor.notice).to eq('Ошибка, неправильный перевод')
  end
end
