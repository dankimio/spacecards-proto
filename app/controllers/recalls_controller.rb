class RecallsController < ApplicationController
  before_action :set_deck

  def new
    @card = @deck.cards.first
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end
end
