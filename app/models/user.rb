class User < ApplicationRecord
  has_many :decks, dependent: :destroy
  has_many :cards, through: :decks

  # Others available are: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :omniauthable, :trackable, :validatable,
         omniauth_providers: %i[google_oauth2 twitter]

  after_create_commit :add_sample_data

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def add_sample_data
    {
      'U.S. State Capitals' => 'us_capitals.json',
      'World Capitals' => 'world_capitals.json'
    }.each do |name, filename|
      path = Rails.root.join('lib', 'data', filename)
      data = JSON.parse(File.read(path))

      deck = decks.create(name: name)
      cards = data.map { |front, back| { front: front, back: back, deck_id: deck.id } }
      Card.import(cards)
      Deck.update_counters(deck.id, cards_count: data.size)
    end
  end
end
