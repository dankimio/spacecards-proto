class AddLimitsToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :new_cards_per_day, :integer
    add_column :decks, :reviews_per_day, :integer
  end
end
