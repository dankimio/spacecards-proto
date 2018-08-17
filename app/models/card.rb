class Card < ApplicationRecord
  belongs_to :deck, counter_cache: true

  scope :due, -> { where('due_on <= ? OR due_on IS NULL', Date.today) }
  scope :random, -> { order('RANDOM()') }

  def recall(quality)
    flashcard = Repetition::Flashcard.new(
      easiness_factor: easiness_factor,
      repetitions: repetitions,
      interval: interval
    )

    update(due_on: flashcard.recall(quality))
  end
end
