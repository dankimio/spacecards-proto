class RecallsController < ApplicationController
  before_action :set_deck, only: %i[index new]
  before_action :set_card, only: %i[create]

  def index
    @card = @deck.cards.first
  end

  def new
    @card = @deck.cards.first

    respond_to do |format|
      format.json
    end
  end

  def create
    @card.update(due_on: Date.tomorrow)
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def set_card
    @card = Card.find(params[:card_id])
  end
end
