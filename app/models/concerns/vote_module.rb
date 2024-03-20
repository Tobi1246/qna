module VoteModule
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :voteble
  end

  def good_vote
    votes.where(vote_score: 1).count
  end

  def bad_vote
    votes.where(vote_score: -1).count
  end

  def result_vote
    votes.pluck(:vote_score).sum
  end

  def user_voted?(id)
    votes.where(user_id: id).present?
  end
      
end