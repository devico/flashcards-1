class CreateAddNameToDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :add_name_to_decks do |t|
      t.string :name

      t.timestamps
    end
  end
end
