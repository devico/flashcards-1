class CheckTranslation
  include Interactor
def call
  card_check = Card.find_by(id: context.card_id)
  if card_check.original_text.strip == context.users.strip
    card_check.update(review_date: 3.days.since)
    context.notice = 'Все верно! Для закрепления повторим через три дня'
  else
    context.notice ='Ошибка, неправильный перевод'
  end
end
end
