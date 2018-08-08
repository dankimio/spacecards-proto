class RecallsController < ApplicationController
  before_action :set_deck, only: %i[index new]
  before_action :set_card, only: %i[create]

  def index
  end

  def new
    @cards = @deck.cards.due

    respond_to do |format|
      format.json
    end
  end

  def create
    if @card.update(due_on: Date.tomorrow)
      head :ok
    else
      head 422
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def set_card
    @card = Card.find(params.dig(:card, :id))
  end
end
