class Deck < ApplicationRecord
  belongs_to :user

  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :new_cards_per_day, :reviews_per_day, numericality: { greater_than: 0 }
end
