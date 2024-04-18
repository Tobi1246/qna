class Coment < ApplicationRecord
  belongs_to :comentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true
end
