require 'test_helper'

class CardTest < ActiveSupport::TestCase
  setup do
    @card = cards(:card)
  end

  test 'valid' do
    assert @card.valid?
  end
end
