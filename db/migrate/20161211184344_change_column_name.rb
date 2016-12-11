class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :deck, :deck_id
  end
end
