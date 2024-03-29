# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'foo@bar.com', password: 'qwerty123')

5.times do |i|
  deck = Deck.create!(name: "Deck #{i + 1}", user: user)

  3.times do |i|
    deck.cards.create!(front: "Front #{i + 1}", back: "Back #{i + 1}")
  end
end
