class Card < ApplicationRecord
  belongs_to :deck, counter_cache: true
end
