module VoteModule
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def good_votes
    votes.good.count
  end

  def bad_votes
    votes.bad.count
  end

  def result_vote
    votes.sum(:vote_score)
  end

  def user_voted?(id)
    votes.where(user_id: id).present?
  end
end
