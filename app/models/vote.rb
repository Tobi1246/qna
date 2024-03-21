class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => [:votable_type, :votable_id] }

  scope :good, -> { where(vote_score: 1) }
  scope :bad, -> { where(vote_score: -1) }  
end
