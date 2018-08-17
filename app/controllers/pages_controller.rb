class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to decks_url if user_signed_in?
  end
end
