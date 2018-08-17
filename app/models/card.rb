class Card < ApplicationRecord
  belongs_to :deck, counter_cache: true

  scope :due, -> { where('due_on <= ? OR due_on IS NULL', Date.today) }
  scope :random, -> { order('RANDOM()') }
  scope :new_cards, -> { where(recalled_at: nil) }
  scope :review_cards, -> { where.not(recalled_at: nil) }
  scope :recalled_today, -> { where('recalled_at > ?', Time.zone.now.beginning_of_day) }

  def recall(quality)
    flashcard = Repetition::Flashcard.new(
      easiness_factor: easiness_factor,
      repetitions: repetitions,
      interval: interval
    )
    flashcard.recall(quality)
    update(
      easiness_factor: flashcard.easiness_factor,
      repetitions: flashcard.repetitions,
      interval: flashcard.interval,
      due_on: flashcard.due_on,
      recalled_at: Time.zone.now
    )
  end
end
