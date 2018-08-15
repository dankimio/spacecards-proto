class DecksController < ApplicationController
  def index
    @decks = current_user.decks
  end

  def show
    @deck = current_user.decks.find(params[:id])
  end

  def new
    @deck = current_user.decks.build
  end

  def create
    @deck = current_user.decks.build(deck_params.merge(user: User.first))

    if @deck.save
      redirect_to @deck, notice: 'Deck was created successfully'
    else
      render :new
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end
