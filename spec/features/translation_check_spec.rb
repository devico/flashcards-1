require "rails_helper"

RSpec.feature "Translation check" do
  before(:each) do
    #record_time = 3.days.ago
    #Time.stub(:now) { record_time }
    @user = create(:user, email: 'user@rails.com', password: 'secret')
    @deck = create(:deck, name: 'testing', user_id: @user.id)
    create(:card, original_text: 'Correct translation', translated_text: 'Text to check', user_id: @user.id, deck_id: @deck.id, review_date: Date.today)
    login_user
  end
  scenario "User activates Deck and sees cards from it" do
    visit "/"
    expect(page).to have_text("случайные")
    visit "/decks"
    click_link "Выбрать"
    visit "/"
    expect(page).to have_text("testing")
  end
  scenario "User inputs correct translation and checks the result" do
    visit "/"
    fill_in "Перевод", with: 'Correct translation'
    click_button "Проверить"
    expect(page).to have_text("верно")
  end
  scenario "User inputs wrong translation and checks the result" do
    visit "/"
    fill_in "Перевод", with: 'Wrong translation'
    click_button "Проверить"
    expect(page).to have_text("Ошибка")
  end
  scenario "User creates card and can see it card's list" do
    visit "/cards/new"
    select 'testing', from: 'Выберите колоду'
    fill_in "Оригинальный текст:", with: 'My original text'
    fill_in "Перевод:", with: 'My translation'
    click_button "Сохранить карточку"
    expect(page).to have_text(@deck.id)
    expect(page).to have_text('Удалить')
    expect(page).to have_text('My translation')
  end
end
