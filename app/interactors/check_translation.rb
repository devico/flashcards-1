class CheckTranslation
  include Interactor
  require 'levenshtein'
  
  def call
    getting_card
    if card_check
      correct_answer
    else
      incorrect_answer
    end
  end
  
  def card_check
    passing_score = 0.15
    size = @card_check.original_text.strip.size
    score = Levenshtein.distance(@card_check.original_text.strip, context.users.strip)
    @users_score = score.to_f/size.to_f
    @users_score <= passing_score
  end
  
  def getting_card
    @card_check = Card.find_by(id: context.card_id)
  end
  
  def correct_answer
    if @users_score.positive?
      mistype
    else
      @card_check.update(correct: @card_check.correct + 1, wrong: 0)
      set_new_review
      context.notice = 'Все верно!'
    end
  end
  
  def mistype
    @card_check.update(correct: @card_check.correct + 1, wrong: 0)
    set_new_review
    context.notice = 'Ответ принимаем, но ты опечатался: твой вариант: ' + context.users.strip + ' правильно: ' + @card_check.original_text.strip
  end
  
  def incorrect_answer
    if @card_check.wrong < 2
      @card_check.update(wrong: @card_check.wrong + 1)
    else
      @card_check.update(correct: 0, wrong: 0)
      @card_check.update(review_date: Time.current)
    end
    context.notice = 'Ошибка, неправильный перевод'
  end
  
  def set_new_review
    @card_check.update(review_date:
      case @card_check.correct
      when 1 then 12.hours.since
      when 2 then 1.week.since
      when 3 then 2.weeks.since
      when 4 then 1.month.since
      else 1.year.since
      end)
  end
end
