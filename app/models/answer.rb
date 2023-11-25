class Answer < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :question

  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  validates :body, presence: true

  scope :sort_by_best, -> { order(best: :desc) }

  def mark_best
    return if best == true

    question.answers.update_all(best: false)
    update(best: true)
  end
end
