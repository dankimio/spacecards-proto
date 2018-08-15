class DecksController < ApplicationController
  before_action :set_deck, only: %i[show edit update destroy]

  def index
    @decks = current_user.decks
  end

  def show
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

  def edit
  end

  def update
    if @deck.update(deck_params)
      redirect_to @deck, notice: 'Deck was updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path, notice: 'Deck was successfully deleted'
  end

  private

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end
end
