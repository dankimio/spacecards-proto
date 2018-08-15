require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  setup do
    @deck = decks(:deck)
  end

  test 'valid' do
    assert @deck.valid?
  end
end
