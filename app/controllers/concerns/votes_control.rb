module VotesControl
  extend ActiveSupport::Concern

  included do
    before_action :votable, only: %i[good_vote bad_vote destroy_vote]
  end
  
  def good_vote
    vote(1)
  end

  def bad_vote
    vote(-1)
  end

  def destroy_vote
    @vote = Vote.find_by(user: current_user, votable_type: votable.class.to_s, votable_id: votable.id)
    #current_user.votes.where(votable: votable).destroy
    return not_found if @vote == nil
    @vote.destroy
    respond_format_json(votable)
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end  

  def vote(value)
    votable.votes.new(user: current_user, vote_score: value)
    respond_format_json(votable)    
  end

  def error(param)
    render json: param.errors.full_messages, status: :unprocessable_entity
  end

  def votable
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
