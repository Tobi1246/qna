class AnswersController < ApplicationController
  include VotesControl
  include ComentControl

  before_action :authenticate_user! 
  before_action :find_question, only: %i[create edit]
  before_action :set_answer, only: %i[destroy update mark_best destroy_vote good_vote bad_vote create_coment ]
  after_action :publish_answer, only: %i[create]

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

  def publish_answer
    unless @answer.errors.any?
      rendered_answer = ApplicationController.render(
        partial: 'answers/answer_broadcast',
        locals: { answer: @answer }
      )

      ActionCable.server
                 .broadcast("question-#{@question.id}",
                            {
                              answer: rendered_answer,
                              answer_id: @answer.id,
                              answer_author_id: @answer.author.id,
                              question_author_id: @question.author.id
                            })
    end
  end  

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
