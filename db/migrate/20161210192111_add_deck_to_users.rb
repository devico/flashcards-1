class AddDeckToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :deck, :integer
  end
end
