class Deck < ApplicationRecord
  REVIEWS_PER_DAY = 20

  belongs_to :user

  has_many :cards, dependent: :destroy do
    def for_review
      deck = proxy_association.owner
      reviews_per_day = deck.reviews_per_day || REVIEWS_PER_DAY
      cards_limit = reviews_per_day - recalled_today.count

      due.limit(cards_limit < 0 ? 0 : cards_limit)
    end
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :new_cards_per_day, :reviews_per_day, numericality: { greater_than: 0 }, allow_nil: true
end
