class Question < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :answers, dependent: :destroy

  include AttachFile
  include VoteModule
  include Comentable

  validates :title, :body, presence: true
end
