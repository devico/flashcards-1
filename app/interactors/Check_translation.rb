class CheckTranslation

include Interactor

def call

if context.original.strip == context.users.strip
  context.card.update(review_date: 3.days.since)
else
  context.fail!
end

end
end
