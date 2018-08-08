# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'foo1@bar.com', password: 'qwerty123')

5.times do |i|
  deck = Deck.create!(name: "Deck #{i}", user: user)

  10.times do |i|
    deck.cards.create!(front: "Front #{i}", back: "Back #{i}")
  end
end
