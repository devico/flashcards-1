require "rails_helper"
RSpec.feature "Translation check" do
  before do
    record_time = 3.days.ago
    Time.stub(:now) { record_time }
    create(:card, original_text: 'Correct translation', translated_text: 'Text to check')
  end
  scenario "User inputs correct translation and checks the result" do
    visit "/"
    fill_in "Перевод", with: 'Correct translation'
    click_button "Проверить"
    expect(page).to have_text("Все верно")
  end
  scenario "User inputs wrong translation and checks the result" do
    visit "/"
    fill_in "Перевод", with: 'Wrong translation'
    click_button "Проверить"
    expect(page).to have_text("Ошибка")
  end
end
