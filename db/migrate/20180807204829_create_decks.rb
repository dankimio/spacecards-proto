class CreateDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
