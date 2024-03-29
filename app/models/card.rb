class Card < ApplicationRecord
  belongs_to :deck, counter_cache: true

  scope :due, -> { where('due_at <= ? OR due_at IS NULL', Time.zone.now) }
  scope :random, -> { order('RANDOM()') }
  scope :recalled_today, -> { where('recalled_at >= ?', Time.zone.now.beginning_of_day) }

  validates :front, :back, length: { minimum: 1, maximum: 255 }

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
      due_at: flashcard.due_at,
      recalled_at: Time.zone.now
    )
  end

  def front_html
    Kramdown::Document.new(front).to_html
  end

  def back_html
    Kramdown::Document.new(back).to_html
  end
end
