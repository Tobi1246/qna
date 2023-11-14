class Answer < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :question

  validates :body, presence: true

  scope :sort_by_best, -> { order(best: :desc) }

  def mark_best
    return if best == true

    question.answers.update_all(best: false)
    update(best: true)
  end
end
