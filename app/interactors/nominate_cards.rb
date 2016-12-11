class NominateCards
  include Interactor
def call
  if Deck.exists?(id: context.user.deck_id)
    deck = Deck.find(context.user.deck_id)
    context.status = 'Карточки из колоды ' + deck.name
    context.card = Card.from_active_deck(context.user).review_date_earlier_or_equal.random.first
  else
    context.status = 'Колода не выбрана, показываем случайные карточки'
    context.card = Card.belongs_to_current_user(context.user).review_date_earlier_or_equal.random.first
  end
end
end
