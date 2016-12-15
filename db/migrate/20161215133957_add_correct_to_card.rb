class AddCorrectToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :correct, :integer
  end
end
