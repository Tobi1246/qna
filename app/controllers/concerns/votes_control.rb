module VotesControl
	extend ActiveSupport::Concern
	
	def good_vote_create(param)
		param.votes.new(user: current_user, vote_type: true)
		respond_format_json(param)
	end

	def bad_vote_create(param)
		param.votes.new(user: current_user, vote_type: false)
		respond_format_json(param)
	end

	def delete_vote(param)
		Vote.find_by(user: current_user, voteble_type: param.class.to_s, voteble_id: param.id).destroy
		respond_format_json(param)
	end

	def respond_format_json(param)
		if param.save
			render json: param.result_vote, status: :created
		else
			render json: param.errors.full_messages, status: :unprocessable_entity
		end
	end
end