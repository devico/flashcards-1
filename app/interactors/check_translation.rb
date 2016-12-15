class CheckTranslation
  include Interactor
def call
  @card_check = Card.find_by(id: context.card_id)
    if @card_check.original_text.strip == context.users.strip
      @card_check.update(correct: @card_check.correct + 1, wrong: 0)
      set_new_review
      context.notice = 'Все верно!'
    else
      if @card_check.correct != 3
        @card_check.update(wrong: @card_check.wrong + 1)
      else
        @card_check.update(correct: 0, wrong: 0)
        @card_check.update(review_date: Date.today)
      end
      context.notice ='Ошибка, неправильный перевод'
    end
end

def set_new_review
  @card_check.update(review_date: 
    case @card_check.correct
      when 1 then 12.hours.since
      when 2 then 1.week.since
      when 3 then 2.weeks.since
      when 4 then 1.month.since
      else 1.year.since
    end
  )
end
end
