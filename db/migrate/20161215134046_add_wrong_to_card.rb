class AddWrongToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :wrong, :integer
  end
end
