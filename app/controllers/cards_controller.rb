class CardsController < ApplicationController
  before_action :set_deck, only: %i[index new create]

  def index
    @cards = @deck.cards
  end

  def new
    @card = @deck.cards.build
  end

  def create
    @card = @deck.cards.build(card_params)

    if @card.save
      redirect_to new_deck_card_url(@deck), notice: 'Card was added successfully'
    else
      render :new
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def card_params
    params.require(:card).permit(:front, :back)
  end
end
