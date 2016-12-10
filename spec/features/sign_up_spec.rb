require "rails_helper"
RSpec.feature "Sign up check" do
  scenario "User signs up creates deck and card" do
    visit "/sign_up"
    fill_in "Email:", with: '123@123.ru'
    fill_in "Пароль:", with: 'secret'
    fill_in "Подтвердите пароль:", with: 'secret'
    click_button "Сохранить учетную запись!"
    visit "/decks"
    fill_in "Название колоды:", with: 'Testing'
    click_button "Создать колоду"
    visit "/cards/new"
    select 'Testing', from: 'Выберите колоду'
    fill_in "Оригинальный текст:", with: 'My original text'
    fill_in "Перевод:", with: 'My translation'
    click_button "Сохранить карточку"
    expect(page).to have_text('123@123.ru')
    expect(page).to have_text('Удалить')
    expect(page).to have_text('My translation')
  end
end
