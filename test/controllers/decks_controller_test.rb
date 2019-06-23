require 'test_helper'

class DecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deck = decks(:deck)
    sign_in users(:foo)
  end

  test 'should get index' do
    get decks_url
    assert_response :success
  end

  test 'should get new' do
    get new_deck_url
    assert_response :success
  end

  test 'should create deck' do
    assert_difference('Deck.count') do
      post decks_url, params: { deck: { name: 'New unique name' } }
    end

    assert_redirected_to deck_cards_path(Deck.last)
  end

  test 'should get edit' do
    get edit_deck_url(@deck)
    assert_response :success
  end

  test 'should update deck' do
    patch deck_url(@deck), params: { deck: { name: @deck.name } }
    assert_redirected_to decks_url
  end

  test 'should destroy deck' do
    assert_difference('Deck.count', -1) do
      delete deck_url(@deck)
    end

    assert_redirected_to decks_url
  end
end
