class AddCardsCountToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :cards_count, :integer, default: 0
  end
end
