class CardsController < ApplicationController
  before_action :set_deck, only: %i[index new create]
  before_action :set_card, only: %i[update destroy]

  def index
    @cards = @deck.cards.order(created_at: :desc)
  end

  def new
    @card = @deck.cards.build
  end

  def create
    @card = @deck.cards.build(card_params)
    @card.save
  end

  def update
    @card.update(card_params)
  end

  def destroy
    @card.destroy
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:front, :back)
  end
end
