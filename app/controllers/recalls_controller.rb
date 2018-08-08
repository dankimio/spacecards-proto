class RecallsController < ApplicationController
  before_action :set_deck, only: %i[new]
  before_action :set_card, only: %i[create]

  def new
    @card = @deck.cards.first
  end

  def create
    redirect_to deck_study_url(@card.deck)
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def set_card
    @card = Card.find(params[:card_id])
  end
end
