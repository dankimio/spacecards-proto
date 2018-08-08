class Card < ApplicationRecord
  belongs_to :deck, counter_cache: true

  scope :due, -> { where('due_on <= ?', Date.today) }
end
