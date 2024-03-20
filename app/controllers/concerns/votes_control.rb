module VotesControl
  extend ActiveSupport::Concern

  included do
    before_action :set_model, only: %i[good_vote bad_vote destroy_vote]
  end
  
  def good_vote
    set_model.votes.new(user: current_user, vote_score: 1)
    respond_format_json(set_model)
  end

  def bad_vote
    set_model.votes.new(user: current_user, vote_score: -1)
    respond_format_json(set_model)
  end

  def destroy_vote
    Vote.find_by(user: current_user, voteble_type: set_model.class.to_s, voteble_id: set_model.id).destroy
    respond_format_json(set_model)
  end

  private

  def set_model
    if @answer.nil?
      @question
    else @question.nil?
      @answer
    end
  end

  def respond_format_json(param)
    if param.save
      render json: param.result_vote, status: :created
    else
      render json: param.errors.full_messages, status: :unprocessable_entity
    end
  end
end