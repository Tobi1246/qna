module VotesControl
  extend ActiveSupport::Concern

  included do
    before_action :set_model, only: %i[good_vote bad_vote destroy_vote]
  end
  
  def good_vote
    vote(1)
  end

  def bad_vote
    vote(-1)
  end

  def destroy_vote
    @vote = Vote.find_by(user: current_user, votable_type: set_model.class.to_s, votable_id: set_model.id)
    return error(set_model) if @vote == nil
    @vote.destroy
    respond_format_json(set_model)
  end

  private

  def vote(gooDorBab)
    set_model.votes.new(user: current_user, vote_score: gooDorBab)
    respond_format_json(set_model)    
  end

  def error(param)
    render json: param.errors.full_messages, status: :unprocessable_entity
  end

  def set_model
    @answer || @question
  end

  def respond_format_json(param)
    if param.save
      render json: param.result_vote, status: :created
    else
      render json: param.errors.full_messages, status: :unprocessable_entity
    end
  end
end
