require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deck = decks(:deck)
    @card = cards(:card)
    sign_in users(:foo)
  end

  test 'should get index' do
    get deck_cards_url(@deck)
    assert_response :success
  end

  test 'should get new' do
    get new_deck_card_url(@deck)
    assert_response :success
  end

  test 'should create card' do
    assert_difference('Card.count') do
      post deck_cards_url(@deck), params: { card: { front: @card.front, back: @card.back } }
    end

    assert_redirected_to new_deck_card_url(@deck)
  end

  test 'should update card' do
    patch card_url(@card), params: { card: { front: @card.front, back: @card.back } }
    assert_redirected_to deck_cards_url(@card.deck)
  end

  test 'should destroy card' do
    assert_difference('Card.count', -1) do
      delete card_url(@card)
    end

    assert_redirected_to deck_cards_url(@card.deck)
  end
end
