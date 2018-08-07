class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params.merge(user: User.first))

    if @deck.save
      redirect_to @deck
    else
      render :new
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end
