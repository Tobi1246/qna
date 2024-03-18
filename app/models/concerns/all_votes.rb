module AllVotes
	extend ActiveSupport::Concern

	included do
		has_many :votes, dependent: :destroy, as: :voteble
	end

	def good_vote
		votes.where(vote_type: true).count
	end

	def bad_vote
		votes.where(vote_type: false).count
	end

	def result_vote
		good_vote - bad_vote
	end

	def user_voted?(id)
		votes.where(user_id: id).present?
	end

end