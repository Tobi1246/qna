class AnswersController < ApplicationController
  include VotesControl

  before_action :authenticate_user! 
  before_action :find_question, only: %i[create edit]
  before_action :set_answer, only: %i[destroy update mark_best destroy_vote good_vote bad_vote]

  def create
    @answer = @question.answers.create(answer_params)
  end

  def destroy
    @answer.destroy
  end

  def update
    @answer.update(answer_params)
  end

  def mark_best
    @answer.mark_best
    BadgeService.new(@answer).call  if @answer.best?
    @answers = @answer.question.answers
  end

  def destroy_attach_file
    @file = ActiveStorage::Attachment.find(params[:id])
    @file.purge
  end

  private

  def set_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end  

  def answer_params
    params.require(:answer).permit(:body, :correct, files: [], links_attributes: [:name, :url, :_destroy]).merge(author: current_user)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end  
end
